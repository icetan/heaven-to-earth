goalEl = document.getElementById 'goal'
zeroEl = document.getElementById 'zero'
oneEl = document.getElementById 'one'

trigram = ['☰','☴','☲','☶','☱','☵','☳','☷']
level = 100

round = (value, goal, cursor=0) -> {
  value, goal, cursor
  next:
    if cursor > 2 then value is goal
    else (b) -> round value | b << cursor, goal, cursor+1
}

game = (r) ->
  if typeof r.next is 'function'
    input r, (b) -> game r.next b
  else
    level += if r.next then -10 else 10
    document.body.style.fontSize = level+'vw';
    start()

input = (r, fn) ->
  goal.textContent = trigram[r.goal]
  zeroEl.textContent = trigram[r.value]
  oneEl.textContent = trigram[r.value | 1 << r.cursor]
  zeroEl.onclick = -> fn 0
  oneEl.onclick = -> fn 1

(start = -> game round 0, Math.random()*8|0)()
