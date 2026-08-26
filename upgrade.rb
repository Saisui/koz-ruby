require 'yaml'

g = YAML.load_file(__dir__+"/lib/gem.yaml")
vs = g['version'].split('.').map(&:to_i)
vs[-1]+=1
g['version']=vs.join('.')
File.write __dir__+'/lib/gem.yaml', g.to_yaml
`rake build`
`rake release`