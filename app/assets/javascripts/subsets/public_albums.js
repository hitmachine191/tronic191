Picscasa.Subsets.PublicAlbums = Backbone.Subset.extend({
  url: "albums/public",
  
  comparator: function(album) {
    return (new Date()) - (new Date(album.get('created_at')));
  }
})