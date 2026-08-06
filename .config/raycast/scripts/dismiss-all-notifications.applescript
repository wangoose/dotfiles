#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Dismiss All Notifications
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔕
# @raycast.packageName System

# Documentation:
# @raycast.description Open Notification Center and clear or close notifications.
# @raycast.author wangoose

on openNotificationCenter()
	tell application "System Events"
		tell application process "ControlCenter"
			repeat with itemRef in menu bar items of menu bar 1
				try
					if description of itemRef contains "시계" then
						click itemRef
						delay 0.4
						return true
					end if
				end try
			end repeat
		end tell
	end tell
	
	return false
end openNotificationCenter

on hasNotificationCenterWindow()
	tell application "System Events"
		tell process "NotificationCenter"
			return (count windows) > 0
		end tell
	end tell
end hasNotificationCenterWindow

on performDismissAction(el)
	tell application "System Events"
		set actionNamesToTry to {"모두 지우기", "닫기", "지우기", "Close", "Clear", "Dismiss"}
		
		repeat with actionNameToTry in actionNamesToTry
			try
				set targetAction to first action of el whose name contains (actionNameToTry as text)
				perform targetAction
				return true
			end try
		end repeat
		
		try
			repeat with childEl in UI elements of el
				if my performDismissAction(childEl) then return true
			end repeat
		end try
	end tell
	
	return false
end performDismissAction

on dismissVisibleNotifications()
	tell application "System Events"
		tell process "NotificationCenter"
			set didDismiss to false
			
			repeat with w in windows
				try
					perform action "AXRaise" of w
				end try
				
				if my performDismissAction(w) then
					set didDismiss to true
				end if
			end repeat
			
			return didDismiss
		end tell
	end tell
end dismissVisibleNotifications

tell application "System Events"
	if not my hasNotificationCenterWindow() then
		my openNotificationCenter()
	end if
	
	delay 0.3
	
	repeat 15 times
		if not my hasNotificationCenterWindow() then exit repeat
		
		set didDismiss to my dismissVisibleNotifications()
		
		if didDismiss is false then exit repeat
		
		delay 0.25
	end repeat
	
	try
		key code 53
	end try
end tell

return ""
