{
  "version": 1,
  "disable_existing_loggers": false,
  "formatters": {
    "default": {
      "()": "config.logging_config.ISTFormatter",
      "format": "%(asctime)s - %(message)s",
      "datefmt": "[%Y-%m-%d %H:%M:%S]"
    }
  },
  "handlers": {
    "console": {
      "class": "logging.StreamHandler",
      "formatter": "default",
      "level": "INFO",
      "stream": "ext://sys.stdout"
    }
  },
  "loggers": {
    "uvicorn": {
      "handlers": ["console"],
      "level": "INFO"
    }
  }
}
