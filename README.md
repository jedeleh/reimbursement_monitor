# ReimbursementMonitor

This is a service that will poll insurance vendors periodically to update
  procedure reimbursement amounts. It relies on GenServer to allow this to be
  done asynchonously.

## Requirements (taken directly from the assignment)

  1. The reimbursement amount poll rate is configurable per procedure

  2. When polling for a reimbursement amount, all 3 payors/vendors are polled
    at the same time.

    a. Some payors/vendors may be skipped for certain procedures if they don't reimburse for that procedure.

  3. Our database needs to keep a record for each time interval when the
    procedures were scraped and what the amounts were at that point in time
    across the payors that reimburse for that procedure.

  4. The service should be hands off in that once it is started, it will
    start polling the sources that it has persisted in the database.

## Installation

The usual thing. This was engineered with Elixir 1.8.1 & Erlang/OTP 20

## Code organization

1. Polling tools are found in lib/reimbursement_monitor/polling.
  a. The VendorPolling module exposes a public API to a GenServer that knows how to poll per procedure
2. ReimbursementAmount is the model and it's found in lib/reimbursement_monitor/schemas/reimbursement_amount.ex. All modules/functions around that are found here, including a lightweight context module. 

## Testing  

Run tests with `mix test`.



