"""MkDocs-Hook: ermittelt das Datum des letzten Git-Commits und stellt es als
config.extra.build_date bereit (für die 'Stand:'-Leiste im Header). Fällt auf
das aktuelle Datum zurück, falls kein Git verfügbar ist."""

import subprocess
from datetime import datetime


def on_config(config, **kwargs):
    try:
        date = (
            subprocess.check_output(
                ["git", "log", "-1", "--format=%cd", "--date=format:%d.%m.%Y"],
                stderr=subprocess.DEVNULL,
            )
            .decode()
            .strip()
        )
    except Exception:
        date = datetime.now().strftime("%d.%m.%Y")
    config["extra"]["build_date"] = date
    return config
