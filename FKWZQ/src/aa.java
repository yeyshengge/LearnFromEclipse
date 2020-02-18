function foo(d) {
  let xhr = new XMLHttpRequest()
  xhr.open('GET', `https://olpnhrh8v.qnssl.com/0720web_z/js/${d}.js?v=20170720`)
  xhr.onload = req => {
    if (req.target.status === 200) {
      let limitRegExp = req.target.responseText.match(/var limit=(\[\{.*?\])/)
      if (limitRegExp !== null) {
        let limitText = limitRegExp[1],
          limits = JSON.parse(limitText)
        let clearfixs = document.querySelector('ul.clearfix').childNodes
        for (let index in limits) {
          let clearfix = clearfixs[index],
            limit = limits[index]
          clearfix.querySelector('a > img').src = limit.image_url
          clearfix.querySelector('.ice_game_name').innerText = limit.game_name
          clearfix.querySelector('.sun_cost').innerText = 'Êî´Ù¼Û¸ñ£º' + limit.sale_price
          clearfix.querySelector('.now_cost > i').innerText = limit.list_price
          clearfix.querySelector('.sun_discount').innerText = limit.sc_zk
          clearfix.querySelector('.now_discount').innerText = limit.discount
        }
      }
    }
    else console.error(req.target.status)
  }
  xhr.onerror = err => { console.error(err) }
  xhr.send()
}
// Àý: foo('0723')
