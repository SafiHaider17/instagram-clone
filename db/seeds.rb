# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


<p style="color: green"><%= notice %></p>
<% content_for :title, "Posts" %>
<%= render "posts/filter" %>
<%= link_to "New post", new_post_path, class: "btn btn-primary" %>

<table class="table table-striped table-bordered">
  <thead>
    <tr>
      <th>Image/Video</th>
      <th>Body</th>
      <th>Posted By</th>
      <th>Posted At</th>
      <th>Action</th>
    </tr>
  </thead>
  <tbody>
    <% @posts.each do |post| %>
      <tr id="<%= dom_id(post) %>">
        <td>
          <% if post.image.attached? %>
            <% if post.image.content_type.start_with?('image') %>
              <!-- Image with modal functionality -->
              <%= image_tag(post.image, width: "100", height: "100", class: 'img-fluid', data: { toggle: 'modal', target: "#imageModal#{post.id}" }) %>
              
              <!-- Image Modal -->
              <div class="modal fade" id="imageModal<%= post.id %>" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel<%= post.id %>" aria-hidden="true">
                <div class="modal-dialog" role="document">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title" id="imageModalLabel<%= post.id %>">Post Image</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                      </button>
                    </div>
                    <div class="modal-body">
                      <%= image_tag(post.image, class: 'img-fluid') %>
                    </div>
                  </div>
                </div>
              </div>
            <% elsif post.image.content_type.start_with?('video') %>


              <!-- Video with modal functionality -->
              <button class="btn btn-lg video" data-video="<%= url_for(post.image) %>" data-toggle="modal" data-target="#videoModal<%= post.id %>">
                <%= video_tag(post.image, style: 'max-width:100px;') %>
              </button>

              <!-- Video Modal -->
              <div class="modal fade" id="videoModal<%= post.id %>" tabindex="-1" role="dialog" aria-labelledby="videoModalLabel<%= post.id %>" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body">
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                      </button>
                      <video controls width="100%">
                        <source src="<%= url_for(post.image) %>" type="video/mp4">
                      </video>
                    </div>
                  </div>
                </div>
              </div>
            <% end %>
          <% else %>
            <p>No media attached</p>
          <% end %>
        </td>
        <td><%= post.body %></td>
        <td><%= post.user.username %></td>
        <td><%= post.created_at.strftime("%-l:%M%P, %B %-d, %Y") %></td>
        <td>
          <%= link_to "View", post, class: "btn btn-info btn-sm" %>
          <%= render partial: "likes/button", locals: { post: post } %>
        </td>
      </tr>
    <% end %>
  </tbody>
</table>

<!-- Bootstrap and jQuery (required for modal functionality) -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- jQuery Script to load the video into the modal -->
<script>
  $(function() {
    // Play Video in Modal
    $(".video").click(function () {
      var theModal = $(this).data("target"),
          videoSRC = $(this).attr("data-video"),
          videoSRCauto = videoSRC + "";
      $(theModal + ' source').attr('src', videoSRCauto);
      $(theModal + ' video').load();
      $(theModal + ' video').attr('src', videoSRCauto);
    });

    // Reset the video source when the modal is closed
    $('.modal').on('hidden.bs.modal', function () {
      $(this).find('source').attr('src', '');
      $(this).find('video')[0].pause();
    });
  });
</script>








