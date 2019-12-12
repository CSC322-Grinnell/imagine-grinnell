# Database and Models

Refer to files in `db/migrate`.

## Preexisting unused database tables

### User

Type | Field Name
--- | ---
string | email
string | password_digest

### Garden Produce

Type | Field Name
--- | ---
string | garden_id
string | produce_id
string | available_at
integer | readiness
string | planted_at

## Currently used database tables

### Crop

Type | Field Name
--- | ---
integer | produce
integer | garden_id
string | planted_at
text | description

### Garden

Type | Field Name
--- | ---
string | name
string | address
float | lat
float | long
string | contact_name_1
string | contact_number_1
string | email_1
string | contact_name_2
string | contact_number_2
string | email_2
string | image

### Produce

Type | Field Name
--- | ---
string | name
int | during
date | start_date
date | end_date
string | image
string | type

AnnualProduce and PerennialProduce are inherited from Produce using Single Table Inheritance (STI).
[Explanation of STI](https://medium.com/@dcordz/single-table-inheritance-using-rails-5-02-6738bdd5101a)

When you create an AnnualProduce or PerennialProduce table, the type attribute contains the value of "AnnualProduce" or "PerennialProduce", which you can use to determine the type of the produce.

***

#### Annual Produce

Type | Field Name | Value
--- | --- | ---
string | name | xxx
int | during | xxx
date | start_date | null
date | end_date | null
string | image | xxx
string | type | AnnualProduce

#### Perennial Produce

Type | Field Name | Value
--- | --- | ---
string | name | xxx
int | during | null
date | start_date | xxx
date | end_date | xxx
string | image | xxx
string | type | PerennialProduce

***

### Volunteer

Type | Field Name
--- | ---
string | name
int | during

## Model validations

Refer to files under `/app/models` for validations.

### Garden

- `name`, `address`, `lat`, `long`, and `contact_name_1` have to be present.
- Either `contact_number_1` and `email_1` has to be present.
- Either `contact_number_2` and `email_2` has to be present if `contact_name_2` is present.
- `name`, `email_1`, `email_2`, `contact_number_1`, and `contact_number_2` should be in correct formats.

### Produce

- `name` has to be present, unique, and in correct format.
- `type` has to be `AnnualProduce` or `PerennialProduce`.

### Annual Produce

- `duration` has to be present.
- `start_date` and `end_date` have to be absent.

### Perennial Produce

- `duration` has to be absent.
- `start_date` and `end_date` have to be present.