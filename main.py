import requests
import time
import re
import sys
from datetime import datetime, timezone

# ========== CONFIGURATION ==========
WEBHOOK_URL = "https://discord.com/api/webhooks/1488857414148292770/DaYGBd7L4HVAL7GTBSav1rsu9l1-AZRngd8UqETQdd17hLJcnoxtZ_UZsUbYMx9eIuUg"
REFRESH_SECONDS = 30

STAFF = [
    {"name": "ThunderMods",    "role": "👑 Owner"},
    {"name": "SoniSins",       "role": "👑 Owner"},
    {"name": "Hypernova",      "role": "👑 Owner"},
    {"name": "Chaotic_Mind",   "role": "🛡️ Admin"},
    {"name": "PomPomSaturin",  "role": "🛡️ Admin"},
    {"name": "AlterRainbow",   "role": "🛡️ Admin"},
    {"name": "mcdaggitt",      "role": "🔧 Mod"},
    {"name": "Nismo",          "role": "🛡️ Admin"}
]

LAST_STATUS = {}

def fetch_status(username):
    """Fetch user status from ScriptBlox"""
    url = f"https://scriptblox.com/u/{username}"
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9",
        "Accept-Language": "en-US,en;q=0.5",
    }
    
    try:
        response = requests.get(url, headers=headers, timeout=15)
        
        if response.status_code == 200:
            html = response.text
            
            if "Online" in html and "Offline" not in html[:500]:
                status = "🟢 Online"
            elif "Offline" in html[:500]:
                status = "🔴 Offline"
            else:
                status = "❓ Unknown"
            
            match = re.search(r'Last active\s+([\d\s\w]+)', html, re.IGNORECASE)
            last_active = match.group(1).strip() if match else "Unknown"
            
            return status, last_active
            
        elif response.status_code == 403:
            return "🚫 Blocked", "IP may be blocked"
        else:
            return "⚠️ Error", f"HTTP {response.status_code}"
            
    except Exception as e:
        return "⚠️ Error", str(e)[:50]

def get_all_statuses():
    """Get status for all staff members"""
    statuses = {}
    
    for member in STAFF:
        name = member["name"]
        print(f"  → {member['role']} {name}")
        status, last_active = fetch_status(name)
        statuses[name] = {"status": status, "last_active": last_active, "role": member["role"]}
        LAST_STATUS[name] = (status, last_active)
        time.sleep(0.5)  # Delay to avoid rate limiting
    
    return statuses

def build_embed(statuses):
    """Build Discord embed from statuses"""
    fields = []
    online_count = 0
    
    for name, data in statuses.items():
        if "🟢" in data["status"]:
            online_count += 1
        
        fields.append({
            "name": f"{data['role']} {name}",
            "value": f"**Status:** {data['status']}\n**Last active:** {data['last_active']}",
            "inline": True
        })
    
    current_time = datetime.now(timezone.utc)
    
    embed = {
        "title": "📡 ScriptBlox Staff Monitor",
        "description": f"🔄 Updated every {REFRESH_SECONDS} seconds\n👥 Online: {online_count}/{len(STAFF)}",
        "color": 0x2b2d31,
        "fields": fields,
        "footer": {
            "text": f"Last refresh: {current_time.strftime('%Y-%m-%d %H:%M:%S UTC')}"
        },
        "timestamp": current_time.isoformat()
    }
    
    return embed, online_count

def send_to_discord(embed):
    """Send embed to Discord webhook"""
    payload = {"embeds": [embed]}
    
    try:
        response = requests.post(WEBHOOK_URL, json=payload, timeout=10)
        if response.status_code in [200, 204]:
            return True
        else:
            print(f"    Webhook error: {response.status_code}")
            return False
    except Exception as e:
        print(f"    Webhook error: {e}")
        return False

def main():
    """Main loop"""
    print("=" * 60)
    print("🚀 ScriptBlox Staff Monitor Starting...")
    print("=" * 60)
    print(f"🕒 Refresh interval: {REFRESH_SECONDS} seconds")
    print(f"📡 Monitoring {len(STAFF)} staff members")
    print("=" * 60)
    
    update_count = 0
    
    while True:
        try:
            update_count += 1
            print(f"\n[{datetime.now(timezone.utc).strftime('%H:%M:%S')}] Update #{update_count}")
            
            # Get all statuses
            statuses = get_all_statuses()
            
            # Build embed
            embed, online_count = build_embed(statuses)
            
            # Send to Discord
            if send_to_discord(embed):
                print(f"  ✅ Sent (Online: {online_count}/{len(STAFF)})")
            else:
                print(f"  ❌ Failed to send")
            
            # Wait before next update
            time.sleep(REFRESH_SECONDS)
            
        except KeyboardInterrupt:
            print("\n🛑 Monitor stopped by user.")
            break
        except Exception as e:
            print(f"⚠️ Error in main loop: {e}")
            time.sleep(30)  # Wait longer on error

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n👋 Goodbye!")
        sys.exit(0)
