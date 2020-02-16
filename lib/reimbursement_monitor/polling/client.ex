defmodule ReimbursementMonitor.Polling.Client do 
  def poll(payor, _procedure) do 
    # TODO: doing this last, if I get to it. I intend to use HttpPoison to hit
    # the URL and just return the data received
    payor
    |> Ecto.preload()
    # we use the payor to get the polling_url.
  end
end