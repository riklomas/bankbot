import {Socket} from "phoenix"

let socket = new Socket("/socket")

socket.connect()

let channel = socket.channel("chats:teller")
channel.join()

let input    = $("input")
let messages = $("#messages")

input.on("keypress", event => {
  if (event.keyCode === 13) {
    channel.push("message", { message: input.val() })
    input.val("")
    return false;
  }
})

channel.on("message", payload => {
  messages.append(`<div class="message ${payload.user}">${payload.message}</div>`);
})



// export default socket;
