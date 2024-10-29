defmodule ULID.Extension do
  @moduledoc false
  @behaviour Postgrex.Extension

  # h Postgrex.Extension for more information

  @impl true
  def init(opts) do
    Keyword.get(opts, :decode_copy, :copy)
  end

  @impl true
  def matching(_),
    do: [
      type: "ulid",
      type: "_ulid",
      send: "ulid_send",
      receive: "ulid_recv",
      input: "ulid_in",
      output: "ulid_out"
    ]

  @impl true
  def format(_), do: :text

  @impl true
  def encode(_) do
    quote do
      bin when is_binary(bin) ->
        [<<byte_size(bin)::signed-size(32)>> | bin]
    end
  end

  @impl true
  def decode(:reference) do
    quote do
      <<len::signed-size(32), bin::binary-size(len)>> ->
        bin
    end
  end

  def decode(:copy) do
    quote do
      <<len::signed-size(32), bin::binary-size(len)>> ->
        :binary.copy(bin)
    end
  end
end
