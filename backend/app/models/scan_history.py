# app/models/scan_history.py

from sqlalchemy import Column, Integer, String, Text, TIMESTAMP
from app.core.db import Base

class ScanHistory(Base):
    __tablename__ = "scan_history"

    id = Column(Integer, primary_key=True, index=True)
    user_email = Column(String(255), nullable=False)
    image_url = Column(Text, nullable=False)
    detected_disease = Column(String(255))
    scan_date = Column(TIMESTAMP)
