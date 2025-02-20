from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app import crud, schemas
from app.core.db import get_db

router = APIRouter()

@router.get("/history/{user_email}", response_model=List[schemas.ScanHistory])
def get_scan_history(user_email: str, db: Session = Depends(get_db)):
    scan_history = crud.get_scan_history(db, user_email)
    return scan_history
