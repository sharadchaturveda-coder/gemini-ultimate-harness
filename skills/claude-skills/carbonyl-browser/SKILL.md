---
name: carbonyl-browser
description: "Use ONLY when WebFetch/WebSearch cannot do the job — e.g. JavaScript-rendered pages, login-required content, multi-step form flows, or clicking through a UI. Do NOT use when WebFetch or WebSearch would be faster. Prefer this for: SPAs that need JS execution, form submission flows, sites that block curl/fetch, or tasks requiring real browser interaction."
---

# Carbonyl Browser

Carbonyl is a real Chromium browser that renders pages as ASCII art in a tmux pane. Control it programmatically via Chrome DevTools Protocol (CDP) — not keyboard shortcuts.

## Architecture

- **tmux pane** → visual ASCII output (what you "see")
- **CDP WebSocket** → programmatic control (navigate, click, type, read DOM)

Use tmux only to observe; use CDP for all actions.

## Quick Reference

| Goal | Method |
|------|--------|
| Start browser | `tmux` + `npx carbonyl --remote-debugging-port=9222 URL` |
| Navigate | CDP `Page.navigate` |
| Read page text | CDP `Runtime.evaluate` → `document.body.innerText` |
| Click element | CDP `querySelector` → `getBoundingClientRect` → `Input.dispatchMouseEvent` |
| Type in field | CDP `Runtime.evaluate` → `element.value = ...` or `Input.insertText` |
| Get current URL | CDP `Runtime.evaluate` → `location.href` |
| See visual state | `tmux capture-pane -t SESSION -p \| strings \| grep -v '^$'` |

## Setup (One-Time)

```bash
pip install websockets   # Required for CDP
# carbonyl: already available via npx carbonyl
```

## Starting a Session

```bash
# Start browser (use unique session name and port per task)
tmux new-session -d -s browser -x 200 -y 50
tmux send-keys -t browser "npx carbonyl --remote-debugging-port=9222 https://example.com" Enter
sleep 5  # Wait for Chromium to initialize

# Get page ID (needed for all CDP calls)
curl -s http://localhost:9222/json
```

## Core CDP Helper

Use this Python snippet for all CDP operations:

```python
import asyncio, json, websockets

CDP_WS = "ws://localhost:9222/devtools/page/PAGE_ID_HERE"

async def cdp(method, params=None):
    async with websockets.connect(CDP_WS) as ws:
        await ws.send(json.dumps({"id": 1, "method": method, "params": params or {}}))
        return json.loads(await asyncio.wait_for(ws.recv(), timeout=10))

# Get page ID first:
# import urllib.request, json
# pages = json.loads(urllib.request.urlopen("http://localhost:9222/json").read())
# CDP_WS = pages[0]["webSocketDebuggerUrl"]
```

## Navigate

```python
async def navigate(url):
    async with websockets.connect(CDP_WS) as ws:
        await ws.send(json.dumps({"id": 1, "method": "Page.navigate", "params": {"url": url}}))
        await ws.recv()
    await asyncio.sleep(3)  # Wait for page load

asyncio.run(navigate("https://news.ycombinator.com"))
```

## Read Page Content

```python
async def get_text():
    async with websockets.connect(CDP_WS) as ws:
        await ws.send(json.dumps({"id": 1, "method": "Runtime.evaluate",
            "params": {"expression": "document.body.innerText"}}))
        resp = json.loads(await ws.recv())
        return resp["result"]["result"]["value"]

text = asyncio.run(get_text())
```

## Click an Element

```python
async def click(selector):
    async with websockets.connect(CDP_WS) as ws:
        # Get element center coordinates
        expr = f'''
            const el = document.querySelector("{selector}");
            const r = el.getBoundingClientRect();
            JSON.stringify({{x: r.x + r.width/2, y: r.y + r.height/2}})
        '''
        await ws.send(json.dumps({"id": 1, "method": "Runtime.evaluate", "params": {"expression": expr}}))
        resp = json.loads(await ws.recv())
        pos = json.loads(resp["result"]["result"]["value"])

        # Dispatch mousePressed + mouseReleased
        for ev_type in ["mousePressed", "mouseReleased"]:
            await ws.send(json.dumps({"id": 2, "method": "Input.dispatchMouseEvent",
                "params": {"type": ev_type, "x": pos["x"], "y": pos["y"],
                           "button": "left", "clickCount": 1}}))
            await ws.recv()
    await asyncio.sleep(2)

asyncio.run(click("a[href*='submit']"))
```

## Type in a Form Field

```python
async def fill_field(selector, value):
    async with websockets.connect(CDP_WS) as ws:
        # Focus + set value via JS (reliable for inputs)
        expr = f'''
            const el = document.querySelector("{selector}");
            el.focus();
            el.value = "{value}";
            el.dispatchEvent(new Event("input", {{bubbles: true}}));
            el.dispatchEvent(new Event("change", {{bubbles: true}}));
            "done"
        '''
        await ws.send(json.dumps({"id": 1, "method": "Runtime.evaluate", "params": {"expression": expr}}))
        await ws.recv()

asyncio.run(fill_field("input[name='q']", "search term"))
```

## Check Visual State

```bash
# Read ASCII rendering (strip block-drawing chars)
tmux capture-pane -t browser -p | strings | grep -v '^$'

# Get current URL from address bar (row 0)
tmux capture-pane -t browser -p | head -1 | grep -oP 'https?://[^\s\]]+'
```

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Trying Ctrl+L, Alt+D, F6 for navigation | These don't work reliably — use CDP `Page.navigate` |
| Sending mouse escape sequences via tmux | Use CDP `Input.dispatchMouseEvent` instead |
| Reading content from ASCII capture | Use CDP `Runtime.evaluate` for reliable text extraction |
| Forgetting `await asyncio.sleep()` after navigate | Chromium needs time to render — always wait 2-4s |
| One WebSocket connection per action | Open/close per action is fine; or keep alive for multi-step |

## Cleanup

```bash
tmux kill-session -t browser
```
