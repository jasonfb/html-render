
This simple gem is for patching a special method onto your Rails controllers called render_html_content. This method allows you to render HTML as a string inside of a JSON result as if it were rendered by Rails.

A complete walk-through with an example app can be found on my blog here: 
https://blog.jasonfleetwoodboldt.com/html-render/



# Setup/Installation:
```
gem 'htmlrender'
```

Close to the top of your ApplicationController, add the following line
```
include HtmlRender
```

That's it!

## Usage:

You use this gem when you want to transfer HTML within a JSON output. render_html_content takes the same arguments as render_to_string, except forces the rendering as if the request was for an HTML format. (render_to_string called within a request for a JSON result will not render as HTML).
=======
```
include HtmlRender
```
That's it!

# Usage:
>>>>>>> 6446e26540cc784f648ddb079bff9319ce1c05bc

Your action will end with something like so:

```
respond_to do |format|
  format.html { render }
  format.json { render json: {
      articles_html: render_html_content(partial: "home/articles", layout: false), 
      pagination_html: render_html_content(partial: "home/articles_pagination", layout: false)
    }
  }
end
```

## Why would you want to do such a thing?

These days, most JSON-based endpoints respond with data (for example, if you are working with a thick-client JS app, you're probably going to be using active_model_serializers or something like that).

I won't get into the thick-client vs. thin-client debate here, but let's just say there can be good use for keeping your view rendering on the server:
  1) re-use of Rails views and partials
  2) adding caching to this methodology can achieve extremely fast results from your server and a fast user experience.
  
So for the sake of this argument let's say you want to do some view rendering on the server and you're not using a thick-client MVC-style framework (Ember, Backbone, React, Angular, etc). In the pseudo-example, I am creating an infinite scrolled page that is operating at HomeController under the index action, although this method can be used anywhere of course.

Note that in my infinite loading page I have a div element with class .articles that contains all my articles, and below that I have a container with class .pagination-container that holds the Next / Previous links. Accept for the sake of the example that we need these links to keep track of which page we're on (even though we are infinite scrolling on this page), and we need them to be updated when the page is appended with more content.

If you made $.ajax requests to your server with a format of HTML, you'd retrieve only 1 html block back. Even if you did pass an option to not display the layout, you still wouldn't be easily able to have to distinct HTML blocks that you could work with independently of eachother. 

Instead, send a request for a JSON format response and label the json according to how you want to use it (in this example articles_html and pagination_html)

You will make $.ajax requests to your server to retrieve updated content from the page (that part of the code is not shown) 

<<<<<<< HEAD
On the back-end controller use the render_html_content method described above. You can then create a JSON response that contains any number of HTML blocks, each named within the JSON output, and work with that response from the Javascript you called it from. 

For example, your action might respond this way:

=======
For example:
>>>>>>> 6446e26540cc784f648ddb079bff9319ce1c05bc
```
render json: {
  articles_html: render_html_content(partial: "home/articles", layout: false),
  pagination_html: render_html_content(partial: "home/articles_pagination", layout: false)
}
```

In the javascript side, you'd be doing something like so (assume some_url is set outside of this code):
<<<<<<< HEAD

=======
>>>>>>> 6446e26540cc784f648ddb079bff9319ce1c05bc
```
$.ajax({
  dataType: "json",
  url: some_url
}).done( function(data) {
  $("div.articles").append(data.articles_html);
  $("div.pagination-container").html(data.pagination_html)
});
```

<<<<<<< HEAD
You can even mix HTML blocks and data in the same JSON output (although this may or may not be a good idea depending on your use cases).
=======
This example is from a basic infinite scroll implementation. In our case, I want to append the HTML content onto the end of an existing DOM element, but replace another DOM element with the text "More than 100 articles" if and only if the articles_count > 100. (This is a contrived example to illustrate that you can mix HTML and data-based respond within the same JSON result.)
>>>>>>> 6446e26540cc784f648ddb079bff9319ce1c05bc

