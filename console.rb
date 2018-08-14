require('pry-byebug')
require_relative('models/bounty_hunter')

BountyHunter.delete_all()

bh1 = BountyHunter.new({
  'name' => 'The Man In Black',
  'species' => 'human',
  'bounty_value' => '1000'
  })

bh2 = BountyHunter.new({
  'name' => 'Boba Fett',
  'species' => 'Mandalorian',
  'bounty_value' => '5000',
  'collected_by' => 'Sarlacc'
  })

bh1.save()
bh2.save()

bounties = BountyHunter.all()

binding.pry
nil
