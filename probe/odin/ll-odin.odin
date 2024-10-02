package main

import "core:fmt"

Node :: struct {
  next: ^void,
  data: int,
}

^head: Node = NULL

// add node
^addNode :: proc(data: int) -> Node {
  ^new: Node = NULL
  // list empty
  if (head == NULL) {
    new = make(size_of(Node)) 
    if (new == NULL) {
      return NULL
    }
    new->data = data
    head = new
    new->next = NULL
  } else {
    new = make(size_of(Node))
    if (new == NULL) {
      return NULL
    }
    new->data = data
    new->next = head
    head = new
  }

  return new
}

// remove node
removeNode :: proc(data: int) -> int {
  ^current: Node = head
  ^prev: Node = head
  for (current != NULL) {
    if (current->data == data) {
    // if current node is the list head
    if (current == head) {
      head = current->next
    } else {
      prev->next = current->next
    }
    return -1
  }
  prev = current
  current = current->next
  }
  return 0
}

insertNode :: proc(data: int, pos: int) -> Node {
  ^current: Node = head
  
}

main :: proc() {

}
