(*
 * Copyright (c) Citrix Systems Inc.
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

open Message_switch_core

type t

(** various limit settings for tracing *)
type config

val term : config Cmdliner.Term.t
(** command-line configuration for tracing *)

val init : config -> t
(** [init config] initializes the trace extension according to [config] *)

val add : t -> Protocol.Event.t -> unit
(** [add t event] adds a new event to the trace buffer [t] without blocking.
    If the trace buffer is full then the oldest event is dropped. *)

val get : t -> int64 -> float -> (int64 * Protocol.Event.t) list Lwt.t
(** [get t from timeout] blocks until some new trace events are
    available in [t] (whose index is > [from]) and returns a list of
    [index, Event.t] *)
