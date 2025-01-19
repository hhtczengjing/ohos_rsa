// Random number generator - requires a PRNG backend, e.g. prng4.js
import {Arcfour, prng_newstate, rng_psize} from "./prng4";

function randoms(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min)
}

function getRandomValues(buf) {
  var min = 0,
    max = 255;
  if (buf.length > 65536) {
    var e = new Error();
    e.message = 'Failed to execute \'getRandomValues\' : The ' + 'ArrayBufferView\'s byte length (' + buf.length + ') exceeds the ' + 'number of bytes of entropy available via this API (65536).';
    throw e;
  }
  if (buf instanceof Uint16Array) {
    max = 65535;
  } else if (buf instanceof Uint32Array) {
    max = 4294967295;
  }
  for (var element in buf) {
    buf[element] = randoms(min, max);
  }
  return buf;
}

let rng_state:Arcfour;
let rng_pool:number[] = null;
let rng_pptr:number;

// Initialize the pool with junk if needed.
if (rng_pool == null) {
  rng_pool = [];
  rng_pptr = 0;
  // Extract entropy (2048 bits) from RNG if available
  const z = new Uint32Array(256);
  getRandomValues(z);
  for (var t = 0; t < z.length; ++t) {
    rng_pool[rng_pptr++] = z[t] & 255;
  }
}

function rng_get_byte() {
  if (rng_state == null) {
    rng_state = prng_newstate();
    // At this point, we may not have collected enough entropy.  If not, fall back to Math.random
    while (rng_pptr < rng_psize) {
      const random = Math.floor(65536 * Math.random());
      rng_pool[rng_pptr++] = random & 255;
    }
    rng_state.init(rng_pool);
    for (rng_pptr = 0; rng_pptr < rng_pool.length; ++rng_pptr) {
        rng_pool[rng_pptr] = 0;
    }
    rng_pptr = 0;
  }
  // TODO: allow reseeding after first request
  return rng_state.next();
}


export class SecureRandom {

  public nextBytes(ba:number[]) {
      for (let i = 0; i < ba.length; ++i) {
          ba[i] = rng_get_byte();
      }
  }
}
