"""CREDPAY Payment Service - FastAPI application entry point.

Run with:
    uvicorn app.main:app --reload --port 8000
"""

from fastapi import FastAPI

from app.routes import router

app = FastAPI(
    title="CREDPAY Payment Service",
    description="Simulated payments backed by the existing credpay PostgreSQL database.",
    version="0.1.0",
)

app.include_router(router)


@app.get("/health", tags=["health"])
def health():
    return {"status": "UP"}
