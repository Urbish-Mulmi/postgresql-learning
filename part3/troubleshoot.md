## DBeaver: PostgreSQL Connection Error

**Error:** PostgreSQL rejected the timezone `Asia/Katmandu` during connection startup.

**Cause:** Client-side timezone configuration. The exact origin of the incorrect identifier wasn't confirmed.

**Fix:** Added `-Duser.timezone=Asia/Kathmandu` below `-vmargs` in DBeaver's `dbeaver.ini`.

**Verification:** Restarted DBeaver and successfully tested the connection.

**Takeaway:** Check client configuration and server logs before changing database settings.