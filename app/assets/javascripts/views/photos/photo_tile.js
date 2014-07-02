Picscasa.Views.PhotoTile = Backbone.View.extend({
  template: JST["photos/photo_tile"],
  
  events: {
    "click .delete-photo": "deletePhoto"
  },
  
  tagName: "li",
  
  render: function() {
    var renderedContent = this.template({
      photo: this.model
    });
    
    this.$el.html(renderedContent);
    return this;
  },
  
  deletePhoto: function(event) {
    event.preventDefault();
    this.model.destroy();
    this.remove();
  }
})