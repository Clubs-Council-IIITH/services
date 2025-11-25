import logging
from datetime import datetime
from zoneinfo import ZoneInfo

class ISTFormatter(logging.Formatter):
    """Custom formatter that converts timestamps to IST timezone"""

    def formatTime(self, record, datefmt=None):
        dt = datetime.fromtimestamp(record.created)

        ist_tz = ZoneInfo("Asia/Kolkata")
        dt = dt.astimezone(ist_tz)

        if datefmt:
            s = dt.strftime(datefmt)
        else:
            s = dt.strftime("[%Y-%m-%d %H:%M:%S]")

        return s
