$(function(){
  var form = $('form#new_task');
  form.submit(function(){ return false; })

  // タスクの追加
  $(document).on('click', 'a#submit', function(e){
    var days_ago = $('input#days_ago', form).val();
    var task_name = $('input#task_name', form).val();
    $.ajax({
      type: 'POST',
      url: '/create',
      data: {task_name: task_name, days_ago: days_ago},
    }).done(function(msg){
      var new_task = $('div#template tr').first().clone();
      new_task.attr('class', JSON.parse(msg).task_id);
      new_task.children()
        .first().text(JSON.parse(msg).days_ago + '日前')
        .next().text(JSON.parse(msg).task_name);
      $('td.button a', new_task).each(function(i){
        $(this).attr('data-id', JSON.parse(msg).task_id);
      });
      $('table#tasks tbody tr', form).last().before(new_task);
      new_task.hide().fadeIn('slow');
      form[0].reset();
    });
    e.preventDefault();
  });

  // タスクの更新
  $(document).on('click', 'a.count_up', function(e){
    var task_id = $(this).attr('data-id');
    $.ajax({
      type: 'POST',
      url: '/update',
      data: {task_id: task_id},
    }).done(function(msg){
      var td = $('tr.'+JSON.parse(msg).task_id, form).children().first().fadeTo('slow', 0.1, function(){
        $(this).text('000日前').fadeTo('slow', 1)
      });
    });
    e.preventDefault();
  });


  // タスクの削除
  $(document).on('click', 'a.delete', function(e){
    var task_id = $(this).attr('data-id');
    $.ajax({
      type: 'POST',
      url: '/delete',
      data: {task_id: task_id},
    }).done(function(msg){
      $('tr.'+JSON.parse(msg).task_id, form).fadeOut('slow');
    });
    e.preventDefault();
  });
});
