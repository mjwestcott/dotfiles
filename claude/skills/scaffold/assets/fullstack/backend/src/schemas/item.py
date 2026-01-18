"""Pydantic schemas for Item."""

from datetime import datetime
from uuid import UUID

from pydantic import BaseModel


class ItemCreate(BaseModel):
    """Schema for creating an item."""

    name: str
    description: str | None = None


class ItemUpdate(BaseModel):
    """Schema for updating an item."""

    name: str | None = None
    description: str | None = None


class ItemResponse(BaseModel):
    """Schema for item response."""

    id: UUID
    name: str
    description: str | None
    created_at: datetime
    updated_at: datetime

    model_config = {"from_attributes": True}
