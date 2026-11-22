<!-- This skills bundle has been generated using 'A-Skills' (https://github.com/a-mcorp/a-skills). -->
# Bill of materials conventions

## Semantic:
- List every part needed. Parts under ≈ 1–2 EUR each (screws, pins, leads, household items) go under Small Parts, without cost.
- Record the actual costs paid, VAT and shipping included.

## Technical:
- When a script generates the bill of materials (e.g. `bom/bom.py` writing `bom/BOM.md`), change its source files (`bom/bom.csv`, `bom/dimensions.csv`) and run the script. Never edit the generated file by hand.
- Keep the sections in this order: Parts, Small Parts, Total, Dimensions, Dimensions Validation, Legend.
- Parts: one table for every part, with the columns Part | Code | Origin | Supplier | Qty | Notes | Paid | Cost (EUR).
  - Code: the maker's part number, and the shop's code with the shop in brackets.
  - Origin: `ordered`, `planned`, `printed` or `at hand`. Parts at hand carry a reference price, not counted as spent.
  - Paid: the amount in the shop's currency. Cost: in EUR, with "≈" for estimates and reference prices.
  - Shipping: one estimated row at the bottom, summed per supplier, with the suppliers in quotes.
- Small Parts: Part | Code | Origin | Supplier | Qty | Where.
- Total: ordered, planned, estimated spend, at hand (reference) and full build value, in EUR, with a column for each other currency paid in.
- Dimensions: Part | Outline | Details | Source, where Source is `measured`, `estimate`, or `datasheet` or `listing`, linked to its URL.
- Dimensions Validation: Part | Value | Maker | Measured | Verdict | Notes, with the verdict written as "comparison → value used" (`matches`, `inaccurate`, `missing`, `no drawing`, `to measure`).
- Legend: one table at the end that explains the terms. Link the table headers to it (e.g. `[Origin](#legend)`).
