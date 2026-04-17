---
name: ffmpeg
description: FFmpeg CLI — transcode video/audio, extract frames, clip segments, convert formats, generate waveforms, process audio for TTS/lipsync pipelines. USE when task involves video/audio file manipulation.
---

# FFmpeg

## When to use ffmpeg vs alternatives

| Situation | Use |
|---|---|
| Convert video/audio format | `ffmpeg` |
| Extract audio from video | `ffmpeg` |
| Clip a segment from a file | `ffmpeg` |
| Extract frames as images | `ffmpeg` |
| Generate waveform/spectrogram data | `ffmpeg` |
| Resize, crop, scale video | `ffmpeg` |
| Merge audio + video tracks | `ffmpeg` |
| Get file duration, codec, resolution | `ffprobe` |
| Record screen/webcam | `ffmpeg` with device input |
| Play a file | use `mpv` or `vlc` instead |

## Inspect a file first

```bash
ffprobe -v quiet -print_format json -show_format -show_streams input.mp4
```

Quick summary:
```bash
ffprobe -v error -show_entries format=duration,size,bit_rate \
  -show_entries stream=codec_name,width,height,r_frame_rate \
  -of default=noprint_wrappers=1 input.mp4
```

## Format conversion

```bash
# Video: mp4 → webm (VP9)
ffmpeg -i input.mp4 -c:v libvpx-vp9 -crs 30 -b:v 0 -c:a libopus output.webm

# Video: any → mp4 (H.264, web-safe)
ffmpeg -i input.mov -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 128k output.mp4

# Audio: wav → mp3
ffmpeg -i input.wav -q:a 2 output.mp3

# Audio: any → ogg (for Three.js audio / Web Audio API)
ffmpeg -i input.mp3 -c:a libvorbis -q:a 4 output.ogg

# Audio: any → wav (uncompressed, for Whisper STT)
ffmpeg -i input.mp3 -ar 16000 -ac 1 -c:a pcm_s16le output.wav
```

## Extract audio from video

```bash
ffmpeg -i input.mp4 -vn -c:a aac -b:a 128k audio.aac
ffmpeg -i input.mp4 -vn -ar 16000 -ac 1 audio.wav   # 16kHz mono for Whisper
```

## Clip a segment

```bash
# Fast seek (keyframe-accurate, re-encodes)
ffmpeg -i input.mp4 -ss 00:01:30 -to 00:02:00 -c copy clip.mp4

# Precise seek (frame-accurate, slightly slower)
ffmpeg -ss 00:01:30 -i input.mp4 -to 00:00:30 -c:v libx264 -c:a aac clip.mp4
```

## Extract frames

```bash
# Every second
ffmpeg -i input.mp4 -vf fps=1 frames/frame_%04d.png

# All frames
ffmpeg -i input.mp4 frames/frame_%04d.png

# Specific time range
ffmpeg -ss 00:00:05 -i input.mp4 -t 10 -vf fps=2 frames/frame_%04d.png

# Single frame at timestamp
ffmpeg -ss 00:00:10 -i input.mp4 -frames:v 1 thumbnail.png
```

## Resize / scale

```bash
# Scale to 720p, keep aspect ratio
ffmpeg -i input.mp4 -vf scale=-1:720 -c:v libx264 output.mp4

# Scale to exact size (may stretch)
ffmpeg -i input.mp4 -vf scale=1280:720 output.mp4

# Scale + pad to 1920x1080 (letterbox)
ffmpeg -i input.mp4 -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2" output.mp4
```

## Audio processing (for AI companion / TTS pipelines)

```bash
# Normalize audio loudness (EBU R128)
ffmpeg -i input.wav -af loudnorm output_normalized.wav

# Remove silence (useful before sending to Whisper)
ffmpeg -i input.wav -af silenceremove=start_periods=1:start_silence=0.1:start_threshold=-50dB \
  output_trimmed.wav

# Resample to 16kHz mono (Whisper input format)
ffmpeg -i input.mp3 -ar 16000 -ac 1 output_whisper.wav

# Split audio into chunks (for long TTS input)
ffmpeg -i input.wav -f segment -segment_time 30 -c copy chunk_%03d.wav

# Mix two audio tracks (e.g. voice + background)
ffmpeg -i voice.wav -i background.mp3 \
  -filter_complex "[1:a]volume=0.15[bg];[0:a][bg]amix=inputs=2:duration=first" \
  mixed.wav
```

## Video for web / VRM companion apps

```bash
# Optimized MP4 for web streaming (faststart = loads header first)
ffmpeg -i input.mp4 -c:v libx264 -crf 23 -preset slow \
  -c:a aac -b:a 128k -movflags +faststart output_web.mp4

# WebM for modern browsers
ffmpeg -i input.mp4 -c:v libvpx-vp9 -crf 30 -b:v 0 \
  -c:a libopus -b:a 128k output.webm

# Generate poster image for video element
ffmpeg -ss 00:00:01 -i input.mp4 -frames:v 1 poster.jpg
```

## Batch processing

```bash
# Convert all MOV files in a directory to MP4
for f in *.mov; do ffmpeg -i "$f" -c:v libx264 -crf 23 -c:a aac "${f%.mov}.mp4"; done

# Extract audio from all MP4s
for f in *.mp4; do ffmpeg -i "$f" -vn -ar 16000 -ac 1 "${f%.mp4}.wav"; done
```

## Common flags reference

| Flag | Meaning |
|---|---|
| `-c copy` | Copy stream without re-encoding (fast, lossless) |
| `-c:v libx264` | H.264 video codec |
| `-c:a aac` | AAC audio codec |
| `-crf 23` | Quality (0=best, 51=worst; 18–28 is typical) |
| `-preset slow` | Slower = better compression, same quality |
| `-vn` | No video (audio only) |
| `-an` | No audio (video only) |
| `-ar 16000` | Audio sample rate (Hz) |
| `-ac 1` | Mono audio |
| `-y` | Overwrite output without asking |
| `-v quiet` | Suppress verbose output |
| `-ss` | Seek to timestamp (before -i = fast, after = precise) |
