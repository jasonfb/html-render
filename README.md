
This simple GEM is for patching a special method onto your Rails controllers called render_html_content. render_html_content allows you to render HTML inside of a JSON result. 


Gem versioning

| Rails version | tested? | use version of this gem |example app|
|---------------|---------|-------------------------|-----------|
| 3.0.20        |         |                         |           |
| 3.1.12        |         |                         |           |
| 3.2.22.5      |         | 0.0.0                   |           |
| 4.1           | tested  | 0.0.0                   |<a href="https://github.com/jasonfb/html-render-example-app-rails4116">example app</a>|
| 4.2           | tested  | 0.0.0                   |<a href="https://github.com/jasonfb/html-render-example-app-rails-425">example app</a>|
| 5.0           |         |                         |          |
| 5.1           |         |                         |          |
| 5.2           |         |                         |          |

# Setup/Installation:
```
gem 'htmlrender'
```

Close to the top of your ApplicationController, add the following line
```
include HtmlRender
```
That's it!

# Usage:

Remember, when the request is for an HTML format, you don't need or use this gem. You use this gem when you want to transfer HTML within a JSON output. render_html_content takes the same arguments as render_to_string, except forces the partials to be rendered as HTML. 

```
respond_to do |format|
  format.html { render }
  format.json { render json: {
      articles_html: render_html_content(partial: "home/articles", layout: false)
    }
  }
end
```

Why would you want to do such a thing?

These days, most JSON-based endpoints respond with data (for example, if you are working with a thick-client JS app, you're probably going to be using active_model_serializers or something like that).

I won't get into the thick-client vs. thin-client debate here, but let's just say there can be good use cases for building an app where most of the view rendering happens on the server. For large-scale, performance based apps you can add caching to this methodology and achieve extremely fast results from your server.

Often, if you are NOT using a thick-client framework (Ember, Backbone, React, Angular, etc), you will make $.ajax requests to your server to retrieve updated content from the page. In the old world, we used to send requests for a format of JS to the server, and the server would respond with the javacsript to do the work of updating the page. I personally find this to be a poor pattern, because it moves the javascript logic itself away from the calling code (where you make the AJAX request).

If you send a request for just HTML, your Rails app can respond with a single HTML block to the $.ajax request. Most of the time this is not sufficient, because you may want (1) some actual json object data returned by the server, or (2) more than one part of the page needing to be updated by the result. 

This strategy is to keep all your JS in one place AND be able update multiple parts of the DOM with the respond, use dataType: "json" in your $.ajax call and on the back-end controller use the render_html_content method described above. You can then create a JSON response that contains any number of HTML blocks, each named within the JSON output, and work with that response from Javascript you called it from. You can even mix HTML blocks and data in the same JSON output. 

For example:
```
render json: {
  articles_html: render_html_content(partial: "home/articles", layout: false),
  articles_count: @articles.count
}
```

In the javascript side, you'd be doing something like so (assume some_url is set outside of this code):
```
$.ajax({
  dataType: "json",
  url: some_url
}).done( function(data) {
  $("div.articles").append(data.articles_html);
  
  if (data.articles_count > 100) {
    $(".articles-count").html("More than 100 articles");
  }
});
```

This example is from a basic infinite scroll implementation. In our case, I want to append the HTML content onto the end of an existing DOM element, but replace another DOM element with the text "More than 100 articles" if and only if the articles_count > 100. (This is a contrived example to illustrate that you can mix HTML and data-based respond within the same JSON result.)

