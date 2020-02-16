defmodule ReimbursementMonitor.Polling.JobAgent do 
  use Agent

  @moduledoc """
    This holds the various jobs so they can be easly fetched and updated as
    needed
  """

  @doc """
  Starts a new JobAgent.
  """
  def start_link(procedure_name) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @doc """
  Gets a value from the `bucket` by `key`.
  """
  def get(procedure_name) do
    Agent.get(__MODULE__, &Map.get(&1, procedure_name))
  end

  @doc """
  Puts the job into the job map using the procedure name as the key.
  Yes, it's kinda unintuitive that the params in the functions are reversed
  as compared to the Map.put call. This is so the JobAgent.put can be used at
  the end of the pipe/chain of functions when a job is created
  """
  def put(job, procedure_name) do
    Agent.update(__MODULE__, &Map.put(&1, procedure_name, job))
  end

  @doc """
  Will fetch the entire job store.
  """
  def all_job_keys do
    Agent.get(__MODULE__, &Map.keys(&1))
  end
end