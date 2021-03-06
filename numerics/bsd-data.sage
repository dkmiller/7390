ds = [1,5,34,1254,29274]
pis = [[1.0] for d in ds]
primes = [1.0 for d in ds]

#exit() # to abort

def ell_data(p,d):
    if 2*d % p == 0: # curve is singular
       return long(p)
    else:
       return long(EllipticCurve(GF(p),[0,0,0,-d^2,0]).cardinality())

for i in range(3000):
    p = Primes().unrank(i)
    for j in range(len(ds)):
        pis[j].append(pis[j][-1] * ell_data(p,ds[j]) / p)
    primes.append(log(long(p)))
    sys.stdout.write("\r%d" % i)
    sys.stdout.flush()

ell_data = [zip(primes, pi) for pi in pis]
ell_log_data = [[(log(p),log(pi)) for (p,pi) in data] for data in ell_data]
p = sum([scatter_plot(e[1:], markersize=1, xmin=1) for e in ell_log_data])

upper_range = 2.7
p += plot(.8, (x,1,upper_range),label='$d=1$')
p += plot(x, (x,1,upper_range), label='$d=5$')
p += plot(2*x-.5, (x,1,upper_range), label='$d=34$')
p += plot(3*x-1.6, (x,1,upper_range), label='$d=1254$')
p += plot(4*x-3.1, (x,1,upper_range), label='$d=29274$')

p.axes_labels(['$\log(\log(x))$', '$\log(\pi_{E_d}(x))$'])

p.save('../../../html/test-plot.svg')
