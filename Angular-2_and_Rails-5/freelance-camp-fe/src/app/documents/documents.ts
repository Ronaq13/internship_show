// Here we are creating interface for a document.
// In easy language : interface is equivalent to making a custom datatype.
// We used snake case here because here we know that we will connect it to rails app

export interface Document {
  title: string,
  description: string,
  file_url: string,
  updated_at: string,
  image_url: string,
}
