  <%@page contentType="text/html" pageEncoding="UTF-8"%>
  
  <!-- Modal -->
  <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
      <div class="modal-content">
        <div class="modal-header text-center">
          <h5 class="modal-title" id="exampleModalLabel">New Blog</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          
          <!-- title -->
          <div class="mb-3">
            <label for="blog-title" class="form-label"><b>Title:</b></label>
            <input type="text" class="form-control" id="blog-title" placeholder="type here...">
          </div>

          <!-- tags -->
          <label for="blog-tag" class="form-label"><b>Catagory:</b></label>
          <div class="form-floating">
            <select class="form-select" id="blog-tag" aria-label="Floating label select example">
              <option selected value="programming">Programming</option>
              <option value="politics">Politics</option>
              <option value="sports">Sports</option>
              <option value="entertainment">Entertainment</option>
            </select>
            <label for="blog-tag">select blog catagory...</label>
          </div>

          <!-- blog content -->
          <label for="blog-content" class="form-label mt-3"><b>Content:</b></label>
          <div class="form-floating">
            <textarea class="form-control" placeholder="type here..." id="blog-content" style="min-height: 100px" rows="8"></textarea>
          </div>

          <!-- blog content -->
          <label for="blog-code-content" class="form-label mt-3"><b>Code:</b></label>
          <div class="form-floating">
            <textarea class="form-control" placeholder="type here..." id="blog-code-content" style="min-height: 100px" rows="8"></textarea>
          </div>




        </div>
        <div class="modal-footer">
          <button type="button"  class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <button type="button" id="blog-upload-btn" class="btn btn-primary"  data-bs-dismiss="modal" style="background-color: rgb(50, 50, 77); border: none;">Save</button>
        </div>
      </div>
    </div>
  </div>
