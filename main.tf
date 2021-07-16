terraform {
  required_providers {
    spotify = {
      version = "~> 0.1.5"
      source  = "conradludgate/spotify"
    }
  }
}



provider "spotify" {
  api_key = var.spotify_api_key
}

locals {
  artists = [
    "Janis joplin", "Lordi",
    "Barbara Pravi", "Linkin Park", "Lordi", "Soprano", "Kendji Girac",
    "Shawn Mendes", "Shakira", "Diam's", "Sia", "Carly Rae Jepsen"
  ]
}

data "spotify_search_track" "by_artist" {
  count   = length(local.artists)
  artists = [local.artists[count.index]]
  limit = 50
}

resource "spotify_playlist" "playlist" {
  name        = "Terraform Summer Playlist"
  description = "This playlist was created by Terraform"
  public      = false

  tracks = flatten(data.spotify_search_track.by_artist[*].tracks[*].id)
}
