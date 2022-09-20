defmodule Fnd.Graph.ParseError do
  @moduledoc false
  require Logger

  def call({:ok, %Neuron.Response{status_code: 200, body: %{"errors" => %{"message" => msg }} = err}}) do
    Logger.error("TheGraph query failed => #{inspect(err)}")
    {:error, msg}
  end

  def call({:ok, %Neuron.Response{status_code: 429} = response}) do
    Logger.error("TheGraph queries have been rate limited  #{inspect(response)}")
    {:error, :rate_limited}
  end

  def call({:error, %Neuron.Response{status_code: 401}}) do
    Logger.error("TheGraph query failed as unauthorized")
    {:error, "unauthorized"}
  end

  def call(error) do
    Logger.error(inspect(error))
    {:error, "An unknown error occured, try later"}
  end
end
