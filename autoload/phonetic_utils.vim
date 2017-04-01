function! s:log (...)
    call call(function('ime#log'), ['phonetic-test'] + a:000)
endfunction


function! s:Init ()
    let s:code_comb = {} " {{{
    let s:code_comb['1'] = {}
    let s:code_comb['1']['u'] = {}
    let s:code_comb['1']['u']['_'] = 1
    let s:code_comb['1']['u'][','] = 1
    let s:code_comb['1']['u']['l'] = 1
    let s:code_comb['1']['u']['0'] = 1
    let s:code_comb['1']['u']['p'] = 1
    let s:code_comb['1']['u']['/'] = 1
    let s:code_comb['1']['j'] = 1
    let s:code_comb['1']['8'] = 1
    let s:code_comb['1']['i'] = 1
    let s:code_comb['1']['9'] = 1
    let s:code_comb['1']['o'] = 1
    let s:code_comb['1']['l'] = 1
    let s:code_comb['1']['0'] = 1
    let s:code_comb['1']['p'] = 1
    let s:code_comb['1'][';'] = 1
    let s:code_comb['1']['/'] = 1
    let s:code_comb['q'] = {}
    let s:code_comb['q']['u'] = {}
    let s:code_comb['q']['u']['_'] = 1
    let s:code_comb['q']['u'][','] = 1
    let s:code_comb['q']['u']['l'] = 1
    let s:code_comb['q']['u']['0'] = 1
    let s:code_comb['q']['u']['p'] = 1
    let s:code_comb['q']['u']['/'] = 1
    let s:code_comb['q']['j'] = 1
    let s:code_comb['q']['8'] = 1
    let s:code_comb['q']['i'] = 1
    let s:code_comb['q']['9'] = 1
    let s:code_comb['q']['o'] = 1
    let s:code_comb['q']['l'] = 1
    let s:code_comb['q']['.'] = 1
    let s:code_comb['q']['0'] = 1
    let s:code_comb['q']['p'] = 1
    let s:code_comb['q'][';'] = 1
    let s:code_comb['q']['/'] = 1
    let s:code_comb['a'] = {}
    let s:code_comb['a']['u'] = {}
    let s:code_comb['a']['u']['_'] = 1
    let s:code_comb['a']['u'][','] = 1
    let s:code_comb['a']['u']['l'] = 1
    let s:code_comb['a']['u']['.'] = 1
    let s:code_comb['a']['u']['0'] = 1
    let s:code_comb['a']['u']['p'] = 1
    let s:code_comb['a']['u']['/'] = 1
    let s:code_comb['a']['j'] = 1
    let s:code_comb['a']['8'] = 1
    let s:code_comb['a']['i'] = 1
    let s:code_comb['a']['k'] = 1
    let s:code_comb['a']['9'] = 1
    let s:code_comb['a']['o'] = 1
    let s:code_comb['a']['l'] = 1
    let s:code_comb['a']['.'] = 1
    let s:code_comb['a']['0'] = 1
    let s:code_comb['a']['p'] = 1
    let s:code_comb['a'][';'] = 1
    let s:code_comb['a']['/'] = 1
    let s:code_comb['z'] = {}
    let s:code_comb['z']['j'] = 1
    let s:code_comb['z']['8'] = 1
    let s:code_comb['z']['i'] = 1
    let s:code_comb['z']['o'] = 1
    let s:code_comb['z']['.'] = 1
    let s:code_comb['z']['0'] = 1
    let s:code_comb['z']['p'] = 1
    let s:code_comb['z'][';'] = 1
    let s:code_comb['z']['/'] = 1
    let s:code_comb['2'] = {}
    let s:code_comb['2']['u'] = {}
    let s:code_comb['2']['u']['_'] = 1
    let s:code_comb['2']['u']['8'] = 1
    let s:code_comb['2']['u'][','] = 1
    let s:code_comb['2']['u']['l'] = 1
    let s:code_comb['2']['u']['.'] = 1
    let s:code_comb['2']['u']['0'] = 1
    let s:code_comb['2']['u']['/'] = 1
    let s:code_comb['2']['j'] = {}
    let s:code_comb['2']['j']['_'] = 1
    let s:code_comb['2']['j']['i'] = 1
    let s:code_comb['2']['j']['o'] = 1
    let s:code_comb['2']['j']['0'] = 1
    let s:code_comb['2']['j']['p'] = 1
    let s:code_comb['2']['j']['/'] = 1
    let s:code_comb['2']['8'] = 1
    let s:code_comb['2']['k'] = 1
    let s:code_comb['2']['9'] = 1
    let s:code_comb['2']['o'] = 1
    let s:code_comb['2']['l'] = 1
    let s:code_comb['2']['.'] = 1
    let s:code_comb['2']['0'] = 1
    let s:code_comb['2']['p'] = 1
    let s:code_comb['2'][';'] = 1
    let s:code_comb['2']['/'] = 1
    let s:code_comb['w'] = {}
    let s:code_comb['w']['u'] = {}
    let s:code_comb['w']['u']['_'] = 1
    let s:code_comb['w']['u'][','] = 1
    let s:code_comb['w']['u']['l'] = 1
    let s:code_comb['w']['u']['0'] = 1
    let s:code_comb['w']['u']['/'] = 1
    let s:code_comb['w']['j'] = {}
    let s:code_comb['w']['j']['_'] = 1
    let s:code_comb['w']['j']['i'] = 1
    let s:code_comb['w']['j']['o'] = 1
    let s:code_comb['w']['j']['0'] = 1
    let s:code_comb['w']['j']['p'] = 1
    let s:code_comb['w']['j']['/'] = 1
    let s:code_comb['w']['8'] = 1
    let s:code_comb['w']['k'] = 1
    let s:code_comb['w']['9'] = 1
    let s:code_comb['w']['l'] = 1
    let s:code_comb['w']['.'] = 1
    let s:code_comb['w']['0'] = 1
    let s:code_comb['w'][';'] = 1
    let s:code_comb['w']['/'] = 1
    let s:code_comb['s'] = {}
    let s:code_comb['s']['u'] = {}
    let s:code_comb['s']['u']['_'] = 1
    let s:code_comb['s']['u']['8'] = 1
    let s:code_comb['s']['u'][','] = 1
    let s:code_comb['s']['u']['l'] = 1
    let s:code_comb['s']['u']['.'] = 1
    let s:code_comb['s']['u']['0'] = 1
    let s:code_comb['s']['u']['p'] = 1
    let s:code_comb['s']['u'][';'] = 1
    let s:code_comb['s']['u']['/'] = 1
    let s:code_comb['s']['j'] = {}
    let s:code_comb['s']['j']['_'] = 1
    let s:code_comb['s']['j']['i'] = 1
    let s:code_comb['s']['j']['0'] = 1
    let s:code_comb['s']['j']['/'] = 1
    let s:code_comb['s']['m'] = {}
    let s:code_comb['s']['m']['_'] = 1
    let s:code_comb['s']['m'][','] = 1
    let s:code_comb['s']['8'] = 1
    let s:code_comb['s']['k'] = 1
    let s:code_comb['s']['9'] = 1
    let s:code_comb['s']['l'] = 1
    let s:code_comb['s']['.'] = 1
    let s:code_comb['s']['0'] = 1
    let s:code_comb['s']['p'] = 1
    let s:code_comb['s'][';'] = 1
    let s:code_comb['s']['/'] = 1
    let s:code_comb['x'] = {}
    let s:code_comb['x']['u'] = {}
    let s:code_comb['x']['u']['_'] = 1
    let s:code_comb['x']['u']['8'] = 1
    let s:code_comb['x']['u'][','] = 1
    let s:code_comb['x']['u']['l'] = 1
    let s:code_comb['x']['u']['.'] = 1
    let s:code_comb['x']['u']['0'] = 1
    let s:code_comb['x']['u']['p'] = 1
    let s:code_comb['x']['u'][';'] = 1
    let s:code_comb['x']['u']['/'] = 1
    let s:code_comb['x']['j'] = {}
    let s:code_comb['x']['j']['_'] = 1
    let s:code_comb['x']['j']['i'] = 1
    let s:code_comb['x']['j']['0'] = 1
    let s:code_comb['x']['j']['p'] = 1
    let s:code_comb['x']['j']['/'] = 1
    let s:code_comb['x']['m'] = {}
    let s:code_comb['x']['m']['_'] = 1
    let s:code_comb['x']['m'][','] = 1
    let s:code_comb['x']['8'] = 1
    let s:code_comb['x']['i'] = 1
    let s:code_comb['x']['k'] = 1
    let s:code_comb['x']['9'] = 1
    let s:code_comb['x']['o'] = 1
    let s:code_comb['x']['l'] = 1
    let s:code_comb['x']['.'] = 1
    let s:code_comb['x']['0'] = 1
    let s:code_comb['x'][';'] = 1
    let s:code_comb['x']['/'] = 1
    let s:code_comb['e'] = {}
    let s:code_comb['e']['j'] = {}
    let s:code_comb['e']['j']['_'] = 1
    let s:code_comb['e']['j']['8'] = 1
    let s:code_comb['e']['j']['i'] = 1
    let s:code_comb['e']['j']['9'] = 1
    let s:code_comb['e']['j']['o'] = 1
    let s:code_comb['e']['j']['0'] = 1
    let s:code_comb['e']['j']['p'] = 1
    let s:code_comb['e']['j'][';'] = 1
    let s:code_comb['e']['j']['/'] = 1
    let s:code_comb['e']['8'] = 1
    let s:code_comb['e']['k'] = 1
    let s:code_comb['e']['9'] = 1
    let s:code_comb['e']['o'] = 1
    let s:code_comb['e']['l'] = 1
    let s:code_comb['e']['.'] = 1
    let s:code_comb['e']['0'] = 1
    let s:code_comb['e']['p'] = 1
    let s:code_comb['e'][';'] = 1
    let s:code_comb['e']['/'] = 1
    let s:code_comb['d'] = {}
    let s:code_comb['d']['j'] = {}
    let s:code_comb['d']['j']['_'] = 1
    let s:code_comb['d']['j']['8'] = 1
    let s:code_comb['d']['j']['i'] = 1
    let s:code_comb['d']['j']['9'] = 1
    let s:code_comb['d']['j']['o'] = 1
    let s:code_comb['d']['j']['0'] = 1
    let s:code_comb['d']['j']['p'] = 1
    let s:code_comb['d']['j'][';'] = 1
    let s:code_comb['d']['j']['/'] = 1
    let s:code_comb['d']['8'] = 1
    let s:code_comb['d']['k'] = 1
    let s:code_comb['d']['9'] = 1
    let s:code_comb['d']['o'] = 1
    let s:code_comb['d']['l'] = 1
    let s:code_comb['d']['.'] = 1
    let s:code_comb['d']['0'] = 1
    let s:code_comb['d']['p'] = 1
    let s:code_comb['d'][';'] = 1
    let s:code_comb['d']['/'] = 1
    let s:code_comb['c'] = {}
    let s:code_comb['c']['a'] = 1
    let s:code_comb['c']['j'] = {}
    let s:code_comb['c']['j']['_'] = 1
    let s:code_comb['c']['j']['8'] = 1
    let s:code_comb['c']['j']['i'] = 1
    let s:code_comb['c']['j']['9'] = 1
    let s:code_comb['c']['j']['o'] = 1
    let s:code_comb['c']['j']['0'] = 1
    let s:code_comb['c']['j']['p'] = 1
    let s:code_comb['c']['j'][';'] = 1
    let s:code_comb['c']['j']['/'] = 1
    let s:code_comb['c']['8'] = 1
    let s:code_comb['c']['k'] = 1
    let s:code_comb['c']['9'] = 1
    let s:code_comb['c']['o'] = 1
    let s:code_comb['c']['l'] = 1
    let s:code_comb['c']['.'] = 1
    let s:code_comb['c']['0'] = 1
    let s:code_comb['c']['p'] = 1
    let s:code_comb['c'][';'] = 1
    let s:code_comb['c']['/'] = 1
    let s:code_comb['r'] = {}
    let s:code_comb['r']['u'] = {}
    let s:code_comb['r']['u']['_'] = 1
    let s:code_comb['r']['u']['8'] = 1
    let s:code_comb['r']['u'][','] = 1
    let s:code_comb['r']['u']['l'] = 1
    let s:code_comb['r']['u']['.'] = 1
    let s:code_comb['r']['u']['0'] = 1
    let s:code_comb['r']['u']['p'] = 1
    let s:code_comb['r']['u'][';'] = 1
    let s:code_comb['r']['u']['/'] = 1
    let s:code_comb['r']['m'] = {}
    let s:code_comb['r']['m']['_'] = 1
    let s:code_comb['r']['m'][','] = 1
    let s:code_comb['r']['m']['0'] = 1
    let s:code_comb['r']['m']['p'] = 1
    let s:code_comb['r']['m']['/'] = 1
    let s:code_comb['f'] = {}
    let s:code_comb['f']['u'] = {}
    let s:code_comb['f']['u']['_'] = 1
    let s:code_comb['f']['u']['8'] = 1
    let s:code_comb['f']['u'][','] = 1
    let s:code_comb['f']['u']['l'] = 1
    let s:code_comb['f']['u']['.'] = 1
    let s:code_comb['f']['u']['0'] = 1
    let s:code_comb['f']['u']['p'] = 1
    let s:code_comb['f']['u'][';'] = 1
    let s:code_comb['f']['u']['/'] = 1
    let s:code_comb['f']['m'] = {}
    let s:code_comb['f']['m']['_'] = 1
    let s:code_comb['f']['m'][','] = 1
    let s:code_comb['f']['m']['0'] = 1
    let s:code_comb['f']['m']['p'] = 1
    let s:code_comb['f']['m']['/'] = 1
    let s:code_comb['v'] = {}
    let s:code_comb['v']['u'] = {}
    let s:code_comb['v']['u']['_'] = 1
    let s:code_comb['v']['u']['8'] = 1
    let s:code_comb['v']['u'][','] = 1
    let s:code_comb['v']['u']['l'] = 1
    let s:code_comb['v']['u']['.'] = 1
    let s:code_comb['v']['u']['0'] = 1
    let s:code_comb['v']['u']['p'] = 1
    let s:code_comb['v']['u'][';'] = 1
    let s:code_comb['v']['u']['/'] = 1
    let s:code_comb['v']['m'] = {}
    let s:code_comb['v']['m']['_'] = 1
    let s:code_comb['v']['m'][','] = 1
    let s:code_comb['v']['m']['0'] = 1
    let s:code_comb['v']['m']['p'] = 1
    let s:code_comb['v']['m']['/'] = 1
    let s:code_comb['5'] = {}
    let s:code_comb['5']['_'] = 1
    let s:code_comb['5']['j'] = {}
    let s:code_comb['5']['j']['_'] = 1
    let s:code_comb['5']['j']['8'] = 1
    let s:code_comb['5']['j']['i'] = 1
    let s:code_comb['5']['j']['9'] = 1
    let s:code_comb['5']['j']['o'] = 1
    let s:code_comb['5']['j']['0'] = 1
    let s:code_comb['5']['j']['p'] = 1
    let s:code_comb['5']['j'][';'] = 1
    let s:code_comb['5']['j']['/'] = 1
    let s:code_comb['5']['8'] = 1
    let s:code_comb['5']['k'] = 1
    let s:code_comb['5']['9'] = 1
    let s:code_comb['5']['o'] = 1
    let s:code_comb['5']['l'] = 1
    let s:code_comb['5']['.'] = 1
    let s:code_comb['5']['0'] = 1
    let s:code_comb['5']['p'] = 1
    let s:code_comb['5'][';'] = 1
    let s:code_comb['5']['/'] = 1
    let s:code_comb['t'] = {}
    let s:code_comb['t']['_'] = 1
    let s:code_comb['t']['j'] = {}
    let s:code_comb['t']['j']['_'] = 1
    let s:code_comb['t']['j']['8'] = 1
    let s:code_comb['t']['j']['i'] = 1
    let s:code_comb['t']['j']['9'] = 1
    let s:code_comb['t']['j']['o'] = 1
    let s:code_comb['t']['j']['0'] = 1
    let s:code_comb['t']['j']['p'] = 1
    let s:code_comb['t']['j'][';'] = 1
    let s:code_comb['t']['j']['/'] = 1
    let s:code_comb['t']['8'] = 1
    let s:code_comb['t']['k'] = 1
    let s:code_comb['t']['9'] = 1
    let s:code_comb['t']['l'] = 1
    let s:code_comb['t']['.'] = 1
    let s:code_comb['t']['0'] = 1
    let s:code_comb['t']['p'] = 1
    let s:code_comb['t'][';'] = 1
    let s:code_comb['t']['/'] = 1
    let s:code_comb['g'] = {}
    let s:code_comb['g']['_'] = 1
    let s:code_comb['g']['j'] = {}
    let s:code_comb['g']['j']['_'] = 1
    let s:code_comb['g']['j']['8'] = 1
    let s:code_comb['g']['j']['i'] = 1
    let s:code_comb['g']['j']['9'] = 1
    let s:code_comb['g']['j']['o'] = 1
    let s:code_comb['g']['j']['0'] = 1
    let s:code_comb['g']['j']['p'] = 1
    let s:code_comb['g']['j'][';'] = 1
    let s:code_comb['g']['8'] = 1
    let s:code_comb['g']['k'] = 1
    let s:code_comb['g']['9'] = 1
    let s:code_comb['g']['o'] = 1
    let s:code_comb['g']['l'] = 1
    let s:code_comb['g']['.'] = 1
    let s:code_comb['g']['0'] = 1
    let s:code_comb['g']['p'] = 1
    let s:code_comb['g'][';'] = 1
    let s:code_comb['g']['/'] = 1
    let s:code_comb['b'] = {}
    let s:code_comb['b']['_'] = 1
    let s:code_comb['b']['j'] = {}
    let s:code_comb['b']['j']['_'] = 1
    let s:code_comb['b']['j']['i'] = 1
    let s:code_comb['b']['j']['o'] = 1
    let s:code_comb['b']['j']['0'] = 1
    let s:code_comb['b']['j']['p'] = 1
    let s:code_comb['b']['j']['/'] = 1
    let s:code_comb['b']['k'] = 1
    let s:code_comb['b']['l'] = 1
    let s:code_comb['b']['.'] = 1
    let s:code_comb['b']['0'] = 1
    let s:code_comb['b']['p'] = 1
    let s:code_comb['b'][';'] = 1
    let s:code_comb['b']['/'] = 1
    let s:code_comb['y'] = {}
    let s:code_comb['y']['_'] = 1
    let s:code_comb['y']['j'] = {}
    let s:code_comb['y']['j']['_'] = 1
    let s:code_comb['y']['j']['i'] = 1
    let s:code_comb['y']['j']['o'] = 1
    let s:code_comb['y']['j']['0'] = 1
    let s:code_comb['y']['j']['p'] = 1
    let s:code_comb['y']['j']['/'] = 1
    let s:code_comb['y']['8'] = 1
    let s:code_comb['y']['k'] = 1
    let s:code_comb['y']['9'] = 1
    let s:code_comb['y']['o'] = 1
    let s:code_comb['y']['l'] = 1
    let s:code_comb['y']['.'] = 1
    let s:code_comb['y']['0'] = 1
    let s:code_comb['y']['p'] = 1
    let s:code_comb['y'][';'] = 1
    let s:code_comb['y']['/'] = 1
    let s:code_comb['h'] = {}
    let s:code_comb['h']['_'] = 1
    let s:code_comb['h']['j'] = {}
    let s:code_comb['h']['j']['_'] = 1
    let s:code_comb['h']['j']['i'] = 1
    let s:code_comb['h']['j']['o'] = 1
    let s:code_comb['h']['j']['0'] = 1
    let s:code_comb['h']['j']['p'] = 1
    let s:code_comb['h']['j']['/'] = 1
    let s:code_comb['h']['8'] = 1
    let s:code_comb['h']['k'] = 1
    let s:code_comb['h']['9'] = 1
    let s:code_comb['h']['l'] = 1
    let s:code_comb['h']['.'] = 1
    let s:code_comb['h']['0'] = 1
    let s:code_comb['h']['p'] = 1
    let s:code_comb['h'][';'] = 1
    let s:code_comb['h']['/'] = 1
    let s:code_comb['n'] = {}
    let s:code_comb['n']['_'] = 1
    let s:code_comb['n']['j'] = {}
    let s:code_comb['n']['j']['_'] = 1
    let s:code_comb['n']['j']['i'] = 1
    let s:code_comb['n']['j']['o'] = 1
    let s:code_comb['n']['j']['0'] = 1
    let s:code_comb['n']['j']['p'] = 1
    let s:code_comb['n']['j']['/'] = 1
    let s:code_comb['n']['8'] = 1
    let s:code_comb['n']['k'] = 1
    let s:code_comb['n']['9'] = 1
    let s:code_comb['n']['l'] = 1
    let s:code_comb['n']['.'] = 1
    let s:code_comb['n']['0'] = 1
    let s:code_comb['n']['p'] = 1
    let s:code_comb['n'][';'] = 1
    let s:code_comb['n']['/'] = 1
    let s:code_comb['u'] = {}
    let s:code_comb['u']['_'] = 1
    let s:code_comb['u']['8'] = 1
    let s:code_comb['u']['i'] = 1
    let s:code_comb['u'][','] = 1
    let s:code_comb['u']['l'] = 1
    let s:code_comb['u']['.'] = 1
    let s:code_comb['u']['0'] = 1
    let s:code_comb['u']['p'] = 1
    let s:code_comb['u'][';'] = 1
    let s:code_comb['u']['/'] = 1
    let s:code_comb['j'] = {}
    let s:code_comb['j']['_'] = 1
    let s:code_comb['j']['8'] = 1
    let s:code_comb['j']['i'] = 1
    let s:code_comb['j']['9'] = 1
    let s:code_comb['j']['o'] = 1
    let s:code_comb['j']['0'] = 1
    let s:code_comb['j']['p'] = 1
    let s:code_comb['j'][';'] = 1
    let s:code_comb['j']['/'] = 1
    let s:code_comb['m'] = {}
    let s:code_comb['m']['_'] = 1
    let s:code_comb['m'][','] = 1
    let s:code_comb['m']['0'] = 1
    let s:code_comb['m']['p'] = 1
    let s:code_comb['m']['/'] = 1
    let s:code_comb['8'] = 1
    let s:code_comb['i'] = 1
    let s:code_comb['k'] = 1
    let s:code_comb['9'] = 1
    let s:code_comb['o'] = 1
    let s:code_comb['l'] = 1
    let s:code_comb['.'] = 1
    let s:code_comb['0'] = 1
    let s:code_comb['p'] = 1
    let s:code_comb[';'] = 1
    let s:code_comb['/'] = 1
    let s:code_comb['-'] = 1
    " }}}

    let s:symbols = 'ㄅㄆㄇㄈㄉㄊㄋㄌㄍㄎㄏㄐㄑㄒㄓㄔㄕㄖㄗㄘㄙㄧㄨㄩㄚㄛㄜㄝㄞㄟㄠㄡㄢㄣㄤㄥㄦˇˋˊ˙'
    let s:codes = '1qaz2wsxedcrfv5tgbyhnujm8ik,9ol.0p;/-3467'

    let s:symbol_set = split(s:symbols, '\zs')
    let s:code_set = split(s:codes, '\zs')
    let s:symbol_code_map = {}

    for l:idx in range(len(s:symbol_set))
        let s:symbol_code_map[s:symbol_set[l:idx]] = s:code_set[l:idx]
        let s:symbol_code_map[s:code_set[l:idx]] = s:symbol_set[l:idx]
    endfor
    let s:symbol_code_map[' '] = ' '
endfunction


function! phonetic_utils#symbols ()
    return s:symbols
endfunction


function! phonetic_utils#code_set ()
    return s:code_set
endfunction


function! phonetic_utils#SymbolStr2CodeList (symbol_str) " {{{
    try
        let l:code_list = map(split(a:symbol_str, '\zs'), 's:symbol_code_map[v:val]')
        if len(filter(copy(l:code_list), 'has_key(s:code_comb, v:val) || v:val =~ ''\v[3467 ]''')) != len(l:code_list)
            call s:log('Parse symbol str failed: "'. a:symbol_str .'", try code str')
            let l:code_list = split(a:symbol_str, '\zs')
        endif

        let l:result = []       " results
        let l:acc = ''          " one char result
        let l:sound = 0         " l:acc has sound or not
        let l:probe = s:code_comb
        for l:code in l:code_list
            if !has_key(l:probe, l:code)
                if l:code =~ '\v[3467 ]' && l:sound == 0
                    " here comes a sound code and we don't have one
                    let l:acc .= l:code
                    let l:probe = {}    " no more code
                    let l:sound = 1
                else
                    call add(l:result, l:acc)
                    let l:acc = l:code
                    let l:probe = s:code_comb[(l:code)]
                    let l:sound = 0
                endif
            else
                let l:acc .= l:code
                if type(l:probe[(l:code)]) == type(1)
                    " found a leaf, but we need to wait for sound code
                    let l:probe = {}
                else
                    let l:probe = l:probe[(l:code)]
                endif
            endif
        endfor
        call add(l:result, l:acc)
        return l:result
    catch
        call s:log('//', 'Cannot parse symbol str: "'. a:symbol_str .'"')
        call s:log('||', v:throwpoint)
        call s:log('\\', v:exception)
        return []
    endtry
endfunction " }}}


function! phonetic_utils#key_to_code (key)
    return s:symbol_code_map[(a:key)]
endfunction


function! phonetic_utils#CodeList2SymbolStr (code_list)
    return join(map(split(join(a:code_list, ''), '\zs'), 's:symbol_code_map[v:val]'), '')
endfunction


call s:Init()
