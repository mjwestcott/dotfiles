"""Example CRUD endpoints for items."""

from typing import Annotated
from uuid import UUID

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from src.database import get_db
from src.models.item import Item
from src.schemas.item import ItemCreate, ItemResponse, ItemUpdate

router = APIRouter()

DB = Annotated[AsyncSession, Depends(get_db)]


@router.get("", response_model=list[ItemResponse])
async def list_items(db: DB) -> list[Item]:
    """List all items (excluding soft-deleted)."""
    result = await db.execute(select(Item).where(Item.deleted_at.is_(None)))
    return list(result.scalars().all())


@router.post("", response_model=ItemResponse, status_code=status.HTTP_201_CREATED)
async def create_item(item_in: ItemCreate, db: DB) -> Item:
    """Create a new item."""
    item = Item(**item_in.model_dump())
    db.add(item)
    await db.flush()
    await db.refresh(item)
    return item


@router.get("/{item_id}", response_model=ItemResponse)
async def get_item(item_id: UUID, db: DB) -> Item:
    """Get a single item by ID."""
    result = await db.execute(select(Item).where(Item.id == item_id, Item.deleted_at.is_(None)))
    item = result.scalar_one_or_none()
    if not item:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Item not found")
    return item


@router.patch("/{item_id}", response_model=ItemResponse)
async def update_item(item_id: UUID, item_in: ItemUpdate, db: DB) -> Item:
    """Update an item."""
    result = await db.execute(select(Item).where(Item.id == item_id, Item.deleted_at.is_(None)))
    item = result.scalar_one_or_none()
    if not item:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Item not found")

    for field, value in item_in.model_dump(exclude_unset=True).items():
        setattr(item, field, value)

    await db.flush()
    await db.refresh(item)
    return item


@router.delete("/{item_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_item(item_id: UUID, db: DB) -> None:
    """Soft delete an item."""
    result = await db.execute(select(Item).where(Item.id == item_id, Item.deleted_at.is_(None)))
    item = result.scalar_one_or_none()
    if not item:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Item not found")

    item.soft_delete()
