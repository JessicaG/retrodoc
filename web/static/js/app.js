// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// import socket and presence
import {Socket, Presence} from "phoenix"

// get user information and connect to socket
let user = document.getElementById("user").innerText;
let socket = new Socket("/socket", {params: {user: user}});
socket.connect();

// displaying presence for users
let presences = {};

let formatTimestamp = (timestamp) => {
  let date = new Date(timestamp)
  return date.toLocaleTimeString()
};

let listBy = (user, {metas: metas}) => {
  return {
    user: user,
    onlineAt: formatTimestamp(metas[0].online_at)
  }
};

let userList = document.getElementById("UserList");

let render = (presences) => {
  userList.innerHTML = Presence.list(presences, listBy)
    .map(presence => `
      <li>
        ${presence.user}
        <br>
        <small>online since ${presence.onlineAt}</small>
      </li>
    `)
    .join("")
};

// Channels
let room = socket.channel("room:january");

room.on("presence_state", state => {
  presences = Presence.syncState(presences, state)
  render(presences)
});

room.on("presence_diff", diff => {
  presences = Presence.syncDiff(presences, diff)
  render(presences)
});

room.join();

let messageInput = document.getElementById("newFeelMessage");

messageInput.addEventListener("keypress", (e) => {
  if (e.keyCode == 13 && messageInput.value != "") {
    room.push("message:new", messageInput.value)
    messageInput.value = ""
  };
});

let messageList = document.getElementById("feelMessageList");

let renderMessage = (message) => {
  let messageElement = document.createElement("li")
  messageElement.innerHTML = `
    <b>${message.user}</b>
    <i>${formatTimestamp(message.timestamp)}</i>
    <p>${message.body}</p>
  `
  messageList.appendChild(messageElement)
  messageList.scrollTop = messageList.scrollHeight;
};

room.on("message:new", message => renderMessage(message));

let dismissAction = document.querySelectorAll(".alert-dismiss");
Array.prototype.slice.call(dismissAction)
  .forEach(function(dismiss) {
    dismiss.addEventListener('click', function(event) {
      event.target.parentNode.style.display = 'none'
    })
  })

let reactionAdd = document.querySelectorAll('.reaction-add')
Array.prototype.slice.call(reactionAdd)
  .forEach(function(add) {
    add.addEventListener('click', function(event) {
      var input = event.target.parentNode.nextElementSibling
      input.style.display = 'block'
    })
  })

let reactionAddInput = document.querySelectorAll('.reaction-add-input')
Array.prototype.slice.call(reactionAddInput)
  .forEach(function(add) {
    add.addEventListener('keyup', function(event) {
      if (event.keyCode === 13) {
        var emoji = event.target.value
        var postId = event.target.dataset.postId
        sendReaction(emoji, postId)
        insertEmoji(emoji, postId)

        event.target.parentNode.style.display = 'none'
      }
    })
  })

function insertEmoji(emoji, postId) {
  var reactions = document.querySelector('ul.reactions')
  var index = reactions.children.length - 2
  var reaction = document.createElement('li')
  var emojiSpan = document.createElement('span')
  reaction.classList.add('reaction')
  emojiSpan.classList.add('reaction-emoji')
  emojiSpan.textContent = emoji
  reaction.appendChild(emojiSpan)

  reactions.insertBefore(reaction, reactions.children[index])
}

function sendReaction(emoji, postId) {
  var body = { emoji: emoji, post_id: postId }
  var csrf = document.getElementById('csrf-token')
  console.log(csrf)
  fetch('/reactions', { body: body, method: 'POST', headers: { 'x-csrf-token' : csrf } })
    // .then(resp => resp.json())
    .then(res => console.log(res))
}

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
