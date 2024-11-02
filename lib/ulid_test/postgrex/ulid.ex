defmodule ULID.Extension do
  @moduledoc """
  This ULID Postgrex.Extension was made for use with: https://github.com/andrielfn/pg-ulid

  `h Postgrex.Extension` for more information
  """
  @behaviour Postgrex.Extension

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
      ulid when ulid == "gen_ulid()" ->
        [<<byte_size(ulid)::signed-size(32)>> | ulid]

      ulid when is_bitstring(ulid) and byte_size(ulid) == 26 ->
        [<<byte_size(ulid)::signed-size(32)>> | ulid]

      [inner] when is_bitstring(inner) and byte_size(inner) == 26 ->
        ulid = "{" <> inner <> "}"
        [<<byte_size(ulid)::signed-size(32)>> | ulid]

      list when is_list(list) ->
        Enum.each(list, fn ulid ->
          unless is_bitstring(ulid) and byte_size(ulid) == 26 do
            raise DBConnection.EncodeError,
                  Postgrex.Utils.encode_msg(ulid, "a string of 26 bytes")
          end
        end)

        ulid_list = "{" <> Enum.join(list, ", ") <> "}"
        [<<byte_size(ulid_list)::signed-size(32)>> | ulid_list]

      other ->
        raise DBConnection.EncodeError, Postgrex.Utils.encode_msg(other, "a string of 26 bytes")
    end
  end

  @impl true
  def decode(:reference) do
    quote do
      <<len::signed-size(32), ulid::binary-size(len)>> ->
        ulid
    end
  end

  def decode(:copy) do
    quote do
      <<len::signed-size(32), ulid::binary-size(len)>> ->
        :binary.copy(ulid)
    end
  end
end
