---
name: ousterhout
description: John Ousterhout's "A Philosophy of Software Design" principles for evaluating code complexity. Reference material for code review and architecture analysis.
---

# Ousterhout's Principles

Core concepts from "A Philosophy of Software Design" for evaluating software complexity.

## Module Depth

A deep module hides significant complexity behind a simple interface. Depth is qualitative - about conceptual weight, not line counts. A shallow module exposes an interface nearly as complex as understanding the implementation directly.

**Critically**: Extracting code into a class doesn't create depth - it just relocates complexity. An abstraction must earn its keep by genuinely hiding something. If methods are mostly one-liners that delegate or accumulate, keep it inline.

**Red flags**: Classes with many public methods but little internal logic. "Manager" or "Helper" classes that just coordinate. Modules where the interface mirrors the implementation. Wrapper methods that rename arguments but hide nothing.

## Information Hiding

Good modules hide implementation details from callers. Leaked abstractions force callers to understand internals they shouldn't need to know.

**Red flags**: Exposed internal types in public interfaces. Configuration options that reveal implementation choices. Temporal coupling (methods must be called in specific order). Invariants callers must maintain.

## Pull Complexity Downward

It's better for the module implementer to handle complexity than to push it onto all callers. If every caller must handle the same edge case, that logic belongs in the implementation.

**Red flags**: Error handling duplicated across callers. Validation logic repeated everywhere. Edge cases the caller must remember to handle.

## Change Amplification

When a simple change requires modifications across many files, it signals poor abstraction boundaries.

**Red flags**: Adding a field requires changes in 5+ places. Similar code scattered across modules. Shotgun surgery pattern.

## Cognitive Load

Code should minimize what readers must hold in their heads to understand it.

**Red flags**: Magic parameters callers won't intuitively understand. Implicit assumptions not documented. Non-obvious ordering requirements. Functions with many parameters.

## Interface Design

Somewhat general-purpose interfaces often outperform highly specialized ones. Over-specific APIs proliferate as new use cases emerge.

**Red flags**: APIs designed for exactly one caller. Many similar functions with slight variations. Missed opportunities for slightly more general abstractions.

## Layer Quality

Each layer should provide a genuinely different abstraction. Pass-through layers that just delegate add complexity without value. Splitting code across files doesn't simplify interfaces - it just spreads the same complexity around.

**Red flags**: Methods that just call the same method on another object. Adjacent layers at similar abstraction levels. Temporal decomposition (organized by execution order rather than concepts). Needing to understand multiple classes to follow a single flow.

## Consistency

Similar things should be done similarly. Inconsistency forces readers to understand unnecessary variations and wonder if differences are meaningful.

**Red flags**: Multiple patterns for the same operation. Naming conventions that vary. Similar functions with different signatures for no reason.

## Error Strategy

Handle errors where context exists to deal with them meaningfully. Translate low-level errors into domain-relevant ones. Best: define errors out of existence through better design.

**Red flags**: Generic exceptions propagated without context. Every caller forced to handle the same errors. Error conditions that could be eliminated by API design. Exception hierarchies without corresponding differentiated handling.

## Comments as Design

Comments should describe the abstraction (what and why), not restate the implementation. Interface contracts should be clear without reading the code.

**Red flags**: Comments that describe what code does line-by-line. Missing documentation of preconditions/postconditions. Readers must reverse-engineer intent.

## Strategic vs Tactical

Strategic programming invests in good design. Tactical programming just makes it work, accumulating complexity over time.

**Red flags**: Quick fixes that became permanent. "We'll clean this up later" patterns. Code that works but nobody wants to touch. Missing "design it twice" consideration.
