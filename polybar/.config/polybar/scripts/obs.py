#!/usr/bin/env python3
import obsws_python as obs
import sys

# --- CONFIGURATION ---
PASSWORD = 'YOUR_OBS_PASSWORD'
PORT = 4455
# ---------------------

try:
    # Connect to the local OBS instance
    cl = obs.ReqClient(host='localhost', port=PORT, password=PASSWORD)
    
    # Check recording status
    if cl.get_record_status().output_active:
        print("%{F#ff0000}⏺ REC%{F-}")  # Bright Red when recording
    else:
        print("%{F#555555}⏺ IDLE%{F-}") # Dim Gray when OBS is open but idle

except Exception:
    # If OBS is completely closed, print nothing so the Polybar module hides itself
    print("") 
    sys.exit(0)
