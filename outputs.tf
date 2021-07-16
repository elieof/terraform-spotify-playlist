output "playlist_url" {
  value       = "https://open.spotify.com/playlist/${spotify_playlist.playlist.id}"
  description = "Visit this URL in your browser to listen to the playlist"
}

output "trackIds" {
  value = flatten(data.spotify_search_track.by_artist[*].tracks[*].id)
}