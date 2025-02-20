# app/schemas/scan_history.py

from pydantic import BaseModel
from typing import Optional
from datetime import datetime

class ScanHistoryBase(BaseModel):
    user_email: str
    image_url: str
    detected_disease: Optional[str] = None

class ScanHistoryCreate(ScanHistoryBase):
    pass

class ScanHistory(ScanHistoryBase):
    id: int
    scan_date: datetime

    class Config:
        orm_mode = True
