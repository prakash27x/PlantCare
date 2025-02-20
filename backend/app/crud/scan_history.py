# app/crud/scan_history.py

from sqlalchemy.orm import Session
from app import models, schemas

def create_scan_history(db: Session, scan_history: schemas.ScanHistoryCreate):
    db_scan_history = models.ScanHistory(
        user_email=scan_history.user_email,
        image_url=scan_history.image_url,
        detected_disease=scan_history.detected_disease
    )
    db.add(db_scan_history)
    db.commit()
    db.refresh(db_scan_history)
    return db_scan_history

def get_scan_history(db: Session, user_email: str):
    return db.query(models.ScanHistory).filter(models.ScanHistory.user_email == user_email).all()
