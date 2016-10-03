defmodule KeyValueStore do
  use GenServer

  @me __MODULE__

  @moduledoc """

  Implement a simple key-value store as a server. This
  version creates a named server, so there is no need
  to pass the server pid to the API calls.

  """
  #######
  # API #
  #######


  @doc """

  Create the key-value store. The optional parameter
  is a collection of key-value pairs which can be used to
  populate the store.

      iex> KeyValueStore.start dave: "thomas"
      iex> KeyValueStore.get :dave
      "thomas"
      iex> KeyValueStore.stop
      :ok

  """

  def start(default \\ []) do
    GenServer.start(__MODULE__, default, name: @me)
  end

  @doc """
  Add or update the entry associated with key.

      iex> KeyValueStore.start dave: 123
      iex> KeyValueStore.get :dave
      123
      iex> KeyValueStore.set :dave, 456
      iex> KeyValueStore.set :language, "elixir"
      iex> KeyValueStore.get :dave
      456
      iex> KeyValueStore.get :language
      "elixir"
      iex> KeyValueStore.stop
      :ok


  """
  def set(key, value) do
    GenServer.cast(@me, { :set, key, value })
  end

  @doc """
  Return the value associated with `key`, or `nil`
  is there is none.

      iex> KeyValueStore.start dave: 123
      iex> KeyValueStore.get :dave
      123
      iex> KeyValueStore.get :language
      nil
      iex> KeyValueStore.stop
      :ok

  """
  def get(key) do
    GenServer.call(@me, { :get, key })
  end

  @doc """
  Return a sorted list of keys in the store.

      iex> KeyValueStore.start dave: 123
      iex> KeyValueStore.keys
      [ :dave ]
      iex> KeyValueStore.set :language, "elixir"
      iex> KeyValueStore.keys
      [ :dave, :language ]
      iex> KeyValueStore.set :author, :jose
      iex> KeyValueStore.keys
      [ :author, :dave, :language ]
      iex> KeyValueStore.stop
      :ok
  """

  def keys do
    IO.puts "not yet implemented"
  end

  @doc """
  Delete the entry corresponding to a key from the store
  
      iex> KeyValueStore.start dave: 123
      iex> KeyValueStore.set :language, "elixir"
      iex> KeyValueStore.keys
      [ :dave, :language ]
      iex> KeyValueStore.delete :dave
      iex> KeyValueStore.keys
      [ :language ]
      iex> KeyValueStore.delete :language
      iex> KeyValueStore.keys
      [ ]
      iex> KeyValueStore.delete :unknown
      iex> KeyValueStore.keys
      [ ]
      iex> KeyValueStore.stop
      :ok
  """
  
  def delete(key) do
    IO.puts "not yet implemented"
  end


  def stop do
    GenServer.stop(@me)
  end

  #######################
  # Server Implemention #
  #######################

  def init(args) do
    { :ok, Enum.into(args, %{}) }
  end

  def handle_cast({ :set, key, value }, state) do
    { :noreply, Map.put(state, key, value) }
  end

  def handle_call({ :get, key }, _from, state) do
    { :reply, state[key], state }
  end

end
