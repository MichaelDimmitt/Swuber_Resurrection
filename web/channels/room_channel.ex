defmodule UnfSwuber.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    side_effects("room:lobby", _message, socket)
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    IO.inspect(%{body: body})
    IO.inspect "could be modified here, web/channels/room_channel handle_in"
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end

  def side_effects("room:lobby", _message, socket) do
    pid = self()
    checkalive = Process.alive?(self())
    IO.puts("room channel entered and not office channel")
  end
end
