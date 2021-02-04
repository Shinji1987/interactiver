$(function() {
  function buildHTML(message){

    var html = `<div class="message-other">
                  <div class="message-time">
                    ${ message.created_at }
                  </div>
                  <span class="message-content-other">${ message.content }</span>
                </div>`;
 
              `<div class="message-time-right">
                <% read = Read.find_by(message_id: message.id) %>
                  <% if read == nil %>
                    <% read_new = Read.create(message_id: message.id, received_user_id: message.received_user_id, complete: false) %>
                    <% read_new.complete == false %>
                    <span class="unread"><%= read_new.complete ? '既読' : '未読' %></span>
                  <% elsif read.complete == true %>
                    <span class="read"><%= read.complete ? '既読' : '未読' %></span>
                  <% else %>
                    <span class="read"><%= read.complete ? '既読' : '未読' %></span>
                  <% end %>
                  ${ message.created_at }
              </div>
              <div class="message-myself">
                <span class="message-content-myself" id="message-myself">${ message.content }</span>
              </div>`;
        return html;
    }
    function scroll() {
      $('.messages').animate({scrollTop: $('.message')[0].scrollHeight});
  }
  $('#new_message').on('submit', function(e) {
      e.preventDefault();
      console.log(this)
// ↓formDataでフォームの情報を取得
    var formData = new 
    FormData(this);
// ↓非同期通信でコメントが保存されるようにする
    var url = $(this).attr("action")
    $.ajax({
      url:url,
      type:"POST",
      data:formData,
      dataType:"json",
      processData:false,
      contentType:false
    })
//↓ 非同期通信成功時に上で定義した関数を実行
    .done (function(data){
      var html = buildHTML(data);
      $(".messages").append(html)
      $(".message-input").val("")
      $('.message-send-btn').prop('disabled', false);
    })
//↓エラー時の処理
    .fail(function(){
      alert("error");
    })
  })
})