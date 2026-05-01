# WORKSTATION

This file defines the durable workstation operating model that Gemini should inherit on fresh installs.

## Interface Model
- User interface is natural-language chat only.
- Agents are the user's hands and operate the machine on the user's behalf.
- User does not directly operate bash, terminals, filesystem navigation, browser GUIs, or admin dashboards.

## Control Plane
- CLI is for agents.
- GUI is for clients and customers.
- Prefer CLI commands, scripts, and APIs before browser or GUI interaction.
- Browser use is fallback-only when no terminal-first path exists.

## Workstation Shape
- This machine is an agent-first host-native workstation.
- Docker is hostile-by-default because it usually reduces agent reach and throughput.

## Harness Homes
- Claude live harness path: `~/.claude` from source repo `claude_code_stuff.git`
- Codex harness: `/home/dr_sharad/codex-stuff-one-umbrella`
- Gemini harness: `/home/dr_sharad/gemini-ultimate-harness`
