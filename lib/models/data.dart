import 'package:flutter/material.dart';

import 'category.dart';

class FactItem {
  final String fact;
  final String imageAlt;
  final String imageUrl;
  final String title;
  final String details;
  final String spotlight;

  FactItem({
    required this.fact,
    required this.imageAlt,
    required this.imageUrl,
    required this.title,
    required this.details,
    required this.spotlight,
  });
}

FactItem _fact({
  required String fact,
  required String imageAlt,
  required String imageUrl,
  required String title,
  required String details,
  required String spotlight,
}) {
  return FactItem(
    fact: fact,
    imageAlt: imageAlt,
    imageUrl: imageUrl,
    title: title,
    details: details,
    spotlight: spotlight,
  );
}

enum AppTab { home, search, saved, profile }

const List<String> dailyFacts = [
  "Honey never spoils. Pots found in ancient Egyptian tombs are still edible!",
  "A 'jiffy' is an actual unit of time: 1/100th of a second.",
  "Sharks existed before trees.",
];

final Map<String, List<FactItem>> factDataStore = {
  'science': [
    _fact(
      fact: "Lightning can power a bulb for 3 months.",
      imageAlt: "Lightning",
      imageUrl:
          "https://www.popsci.com/wp-content/uploads/2020/07/08/ICQ7F5MSCVATDJJFX33WR6IQXI.jpeg?strip=all&quality=85",
      title: "Lightning's Massive Energy Burst",
      details:
          "A single lightning bolt can release an enormous amount of energy in a very short time. Scientists use comparisons like this to help us picture how intense a thunderstorm really is, even if that energy is difficult to capture and store.",
      spotlight:
          "Nature can unleash more energy in a flash than many devices use over long periods.",
    ),
    _fact(
      fact: "Ants outweigh humans globally.",
      imageAlt: "Ants",
      imageUrl:
          "https://thumbs.dreamstime.com/b/many-ants-close-up-huge-army-building-ant-hill-field-macro-work-insect-gut-high-quality-photo-189322253.jpg",
      title: "Tiny Insects, Huge Biomass",
      details:
          "Ants live almost everywhere on Earth and often in enormous colonies. When researchers estimate their combined biomass, the total is so large that it rivals or exceeds the mass of all humans.",
      spotlight:
          "Small creatures can dominate a planet through sheer numbers and teamwork.",
    ),
    _fact(
      fact: "A day on Venus is longer than a year on Venus.",
      imageAlt: "Venus",
      imageUrl:
          "https://www.shutterstock.com/image-illustration/3d-rendering-venus-planet-deep-space-260nw-1315286444.jpg",
      title: "Venus Has an Upside-Down Calendar",
      details:
          "Venus rotates so slowly that it takes longer to spin once on its axis than it takes to complete one orbit around the Sun. That makes a single Venus day longer than a Venus year.",
      spotlight:
          "Planetary time can work very differently from what we experience on Earth.",
    ),
    _fact(
      fact: "Sharks predate Saturn's rings.",
      imageAlt: "Shark",
      imageUrl:
          "http://www.ikelite.com/cdn/shop/articles/great-white-steve-miller.jpg?v=1573442582&width=2048",
      title: "Sharks Are Older Than Saturn's Famous Rings",
      details:
          "Sharks have been around for hundreds of millions of years. Current research suggests Saturn's rings are much younger, which makes sharks older than one of the solar system's most iconic features.",
      spotlight:
          "Some life on Earth is older than things we think of as ancient in space.",
    ),
    _fact(
      fact: "A 'jiffy' is 1/100th of a second.",
      imageAlt: "Time",
      imageUrl:
          "https://media.gettyimages.com/id/1303886185/photo/time-abstract.jpg?s=612x612&w=gi&k=20&c=reXzfsHX7sTVdtmvR4UPXYQZjMFZbdBx1WvXfSDhcy0=",
      title: "A Funny Word With Real Scientific Use",
      details:
          "People often say 'in a jiffy' to mean very quickly, but the word has also been used in technical contexts as a tiny unit of time. That overlap makes it a favorite bit of science trivia.",
      spotlight:
          "Sometimes everyday language sneaks into scientific vocabulary.",
    ),
  ],
  'animals': [
    _fact(
      fact: "A group of flamingos is called a flamboyance",
      imageAlt: "Flamingos",
      imageUrl:
          "https://media.istockphoto.com/id/664986502/photo/group-of-flamingos-standing-in-the-water-in-the-pink-sunset-light-on-lake-nayvasha.jpg?s=612x612&w=0&k=20&c=RPFqfL8xnnXTsBrNzSGlnSn0IRqa09dydOBiHlo7gkQ=",
      title: "Flamingos Have the Perfect Group Name",
      details:
          "Collective nouns for animals often come from old traditions and poetic descriptions. Because flamingos are bright, elegant, and dramatic, flamboyance feels especially fitting.",
      spotlight:
          "Some animal group names are memorable because they match the animal's personality so well.",
    ),
    _fact(
      fact: "A shrimp's heart is in its head",
      imageAlt: "Shrimp",
      imageUrl:
          "https://thumbs.dreamstime.com/b/colorful-shrimp-shine-underwater-detailed-close-up-view-shrimp-showcasing-bright-colors-intricate-details-captured-366372091.jpg",
      title: "Shrimp Anatomy Is Surprisingly Compact",
      details:
          "A shrimp's important organs are packed into a body section called the cephalothorax, where the head and thorax are fused together. That is why the heart seems to be in its head.",
      spotlight:
          "Animal body plans can be very different from the one humans are used to.",
    ),
    _fact(
      fact: "A group of owls is called a parliament",
      imageAlt: "Owls",
      imageUrl:
          "https://preview.redd.it/a-parliament-of-owls-v0-hb3snqlhdj2f1.jpeg?width=1080&crop=smart&auto=webp&s=ef54066c5889d4f30e21d1437a048e0585afa710",
      title: "Owls Earned a Very Formal Group Name",
      details:
          "Owls have long been associated with wisdom in mythology and storytelling. The name parliament reflects that serious, thoughtful image more than any biological feature.",
      spotlight:
          "A lot of animal trivia comes from human imagination as much as science.",
    ),
    _fact(
      fact: "Butterflies taste with their feet",
      imageAlt: "Butterfly",
      imageUrl:
          "https://media.istockphoto.com/id/178473647/photo/common-tiger-butterfly.jpg?s=612x612&w=is&k=20&c=6Um8fErqI9TbstvScdq-sccxMWWJ0VmIzRpXdZ5X084=",
      title: "Butterflies Test Surfaces Before They Eat",
      details:
          "Butterflies have sensory receptors on their feet that detect chemicals on leaves and flowers. That helps them decide where to feed and where to lay eggs.",
      spotlight:
          "Even delicate insects are equipped with specialized sensors for survival.",
    ),
    _fact(
      fact: "A snail can sleep for up to 3 years",
      imageAlt: "Snail",
      imageUrl:
          "https://www.thesprucepets.com/thmb/fy7vBc93G5N6h_7IqnmPsQ4N27g=/2121x0/filters:no_upscale():strip_icc()/GettyImages-1297496329-f85b3ac7fa0e441fb7e04ca64e3a95ce.jpg",
      title: "Snails Can Enter Long Survival Sleep",
      details:
          "Some snails become dormant during extreme dryness or other harsh conditions. This long inactive period helps them conserve moisture and energy until the environment improves.",
      spotlight:
          "Dormancy is one of nature's smartest ways to survive a bad season.",
    ),
  ],
  'christmas': [
    _fact(
      fact: "Jingle Bells was originally written for Thanksgiving",
      imageAlt: "Sleigh Bells",
      imageUrl:
          "https://images.unsplash.com/photo-1543585073-0d5e3aa8e8c3?auto=format&fit=crop&w=800&q=80",
      title: "A Christmas Song With Different Origins",
      details:
          "Jingle Bells was not first created specifically as a Christmas carol. Its snowy imagery and cheerful rhythm later made it one of the songs most strongly associated with Christmas.",
      spotlight:
          "Popular traditions often drift far from the reason they first began.",
    ),
    _fact(
      fact: "The tradition of hiding a pickle ornament on the Christmas tree started in Germany - the finder gets good luck!",
      imageAlt: "Christmas Pickle Ornament",
      imageUrl:
          "https://www.southernliving.com/thmb/Aj0axQsIXG7aou3QJMtjfrqfcWY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/gettyimages-1036321776-2000-6eadeeb3290349a6b6f0e7c95a422b25.jpg",
      title: "The Hidden Pickle Is a Playful Holiday Game",
      details:
          "Whether or not the custom truly began in Germany, many families now enjoy the tradition of hiding a pickle ornament in the tree. It turns decorating into a small holiday treasure hunt.",
      spotlight:
          "Some traditions stick around simply because they are fun to repeat.",
    ),
    _fact(
      fact: "Candy canes were invented to keep children quiet during long Christmas services - shaped like a shepherd's crook",
      imageAlt: "Candy Canes",
      imageUrl:
          "https://i.etsystatic.com/7206602/r/il/8af0fa/6031025046/il_570xN.6031025046_r2n3.jpg",
      title: "Candy Canes Blend Symbolism and Practicality",
      details:
          "The curved shape is often linked to a shepherd's staff in Christian symbolism. At the same time, the treat became a handy way to keep children busy during long holiday services.",
      spotlight:
          "Even familiar holiday sweets can carry stories beyond the candy itself.",
    ),
    _fact(
      fact: "Rudolph the Red-Nosed Reindeer was created in 1939 to sell Christmas toys",
      imageAlt: "Rudolph",
      imageUrl:
          "https://th-thumbnailer.cdn-si-edu.com/WyYImqHD846oDQXEs7dl91sYIt4=/fit-in/1200x0/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/b1/5f/b15f3801-7db6-4806-82b8-b6c53678ef90/hermey_the_elf_and_rudolph.jpg",
      title: "Rudolph Started as a Marketing Character",
      details:
          "The red-nosed reindeer first appeared in a promotional story before becoming a beloved holiday character. It is a good example of advertising creating something that later feels timeless.",
      spotlight:
          "Commercial ideas sometimes grow into traditions people treat like folklore.",
    ),
    _fact(
      fact: "Kissing under the mistletoe comes from ancient fertility rituals",
      imageAlt: "Mistletoe Kiss",
      imageUrl:
          "https://media-cldnry.s-nbcnews.com/image/upload/t_social_share_1200x630_center,f_auto,q_auto:best/newscms/2018_50/1394875/kiss-mistletoe-today-main-181213.jpg",
      title: "Mistletoe Carried Meaning Before Modern Christmas",
      details:
          "Long before it became a holiday decoration, mistletoe was linked with ideas of life, luck, and romance. Those older meanings gradually blended into modern Christmas customs.",
      spotlight:
          "Festive decorations often have stories that are much older than the holiday itself.",
    ),
    _fact(
      fact: "Bing Crosby's 'White Christmas' is the best-selling Christmas song of all time",
      imageAlt: "Snowy Christmas Landscape",
      imageUrl:
          "https://cdn.kpbs.org/dims4/default/f81c60b/2147483647/strip/true/crop/4245x2388+0+1/resize/1200x675!/quality/90/?url=https%3A%2F%2Fnpr.brightspotcdn.com%2Fdims3%2Fdefault%2Fstrip%2Ffalse%2Fcrop%2F4245x2389%200%20203%2Fresize%2F4245x2389%21%2F%3Furl%3Dhttp%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2Fdb%2F95%2F9a048ccc4091a65e34b263500e9a%2Fgettyimages-526898330-1.jpg",
      title: "A Holiday Song That Became a Global Standard",
      details:
          "White Christmas connected with listeners through nostalgia and warmth, especially during the wartime years. Its enormous reach turned it into one of the most recognizable holiday songs ever recorded.",
      spotlight:
          "Music often shapes the emotional memory of a holiday more than decorations do.",
    ),
    _fact(
      fact: "The famous Rockefeller Center Christmas tree tradition started in 1931 by construction workers",
      imageAlt: "Rockefeller Tree",
      imageUrl:
          "https://mychristmasinnewyork.com/wp-content/uploads/2024/05/Rockefeller-Center-Holiday-Tree-NYC-Manhattan.png.webp",
      title: "A Worker Tradition Became a City Landmark",
      details:
          "What began as a small gesture by workers during the Great Depression grew into one of the most famous Christmas displays in the world. Today it is a seasonal symbol of New York City.",
      spotlight:
          "Some of the biggest traditions start as simple community acts.",
    ),
    _fact(
      fact: "Norway gifts a giant Christmas tree to London every year as thanks for WWII help",
      imageAlt: "Trafalgar Square Tree",
      imageUrl: "https://c.files.bbci.co.uk/206E/production/_131920380_treetsq2.jpg",
      title: "A Christmas Tree Given in Gratitude",
      details:
          "The annual tree in Trafalgar Square is a symbol of friendship and remembrance. It honors the support Britain gave Norway during World War II and turns a festive display into a living thank-you.",
      spotlight:
          "Holiday traditions can also serve as memorials and diplomatic gestures.",
    ),
    _fact(
      fact: "Advent calendars originated in Germany in the 1800s to count down to Christmas",
      imageAlt: "Advent Calendar",
      imageUrl:
          "https://brubaker-usa.com/cdn/shop/products/AdventCalendar_PETZ171045__4251219616735.3000.000_beeb114b-49a6-4f0e-9239-188fafcc3e20_1024x1024.jpg?v=1542215176",
      title: "A Countdown Tradition From 19th-Century Germany",
      details:
          "Advent calendars helped families mark the days leading up to Christmas in a fun, visible way. Modern versions with chocolate or gifts keep the same idea of building anticipation day by day.",
      spotlight:
          "Simple countdowns can make a season feel longer and more meaningful.",
    ),
    _fact(
      fact: "The first artificial Christmas trees were made from dyed goose feathers in Germany",
      imageAlt: "Vintage Christmas Tree",
      imageUrl:
          "https://static.vecteezy.com/system/resources/previews/051/042/172/large_2x/close-up-of-a-snow-covered-christmas-tree-decorated-with-gold-and-silver-ornaments-illuminated-by-warm-fairy-lights-photo.jpg",
      title: "Early Artificial Trees Looked Nothing Like Modern Ones",
      details:
          "These feather trees were made as reusable substitutes when access to natural evergreens was limited. They show how festive traditions often adapt to practical needs and available materials.",
      spotlight:
          "Innovation often starts with everyday shortages and creative substitutes.",
    ),
    _fact(
      fact: "Santa's sleigh is pulled by reindeer - in some stories, there are 9 including Rudolph!",
      imageAlt: "Santa Sleigh",
      imageUrl:
          "https://as1.ftcdn.net/jpg/01/29/24/84/1000_F_129248493_24UW44D1VqCHRYTspRUePdufC8krJePC.jpg",
      title: "Santa's Reindeer Team Expanded Over Time",
      details:
          "Early stories named eight reindeer, and Rudolph was added later through modern holiday media. That changing lineup shows how myths keep evolving as new stories become popular.",
      spotlight:
          "Holiday legends stay alive by changing with each generation.",
    ),
  ],
  'space': [
    _fact(
      fact: "Astronauts left footprints on the moon that are still there",
      imageAlt: "Moon Footprint",
      imageUrl: "https://www.nasa.gov/wp-content/uploads/2021/03/pia24543-1-16.jpg",
      title: "Moon Footprints Could Last for Millions of Years",
      details:
          "The Moon has no wind, rain, or flowing water to erase marks on the surface. Because of that, footprints and rover tracks from lunar missions can remain almost unchanged for extremely long periods.",
      spotlight:
          "Without weather, the Moon preserves history in a remarkably direct way.",
    ),
    _fact(
      fact: "Neutron stars can spin up to 700 times per second - faster than a blender!",
      imageAlt: "Pulsar Neutron Star",
      imageUrl: "https://cdn.mos.cms.futurecdn.net/7kCUkCxg6mAD2CXZ9kdKRa.jpg",
      title: "Some Dead Stars Spin at Extreme Speeds",
      details:
          "Neutron stars are the dense remnants of exploded stars. When they spin rapidly, they can rotate hundreds of times each second and sweep beams of radiation through space like giant cosmic lighthouses.",
      spotlight:
          "Extreme gravity creates some of the wildest objects in the universe.",
    ),
    _fact(
      fact: "The first ever photo of a black hole was captured in 2019 by the Event Horizon Telescope",
      imageAlt: "Black Hole Event Horizon",
      imageUrl: "https://scitechdaily.com/images/Black-Hole-Anatomy.jpg",
      title: "A Historic Image Built by a Global Telescope Network",
      details:
          "The famous black hole image was made by linking radio observatories around Earth so they acted like one giant telescope. It was a breakthrough in both astronomy and international scientific collaboration.",
      spotlight:
          "Some discoveries only happen when researchers across the world work as one team.",
    ),
    _fact(
      fact: "Voyager 1 & 2 carry a 'Golden Record' with sounds and images from Earth for aliens",
      imageAlt: "Voyager Golden Record",
      imageUrl: "https://science.nasa.gov/wp-content/uploads/2024/03/voyager-record-diagram.jpeg",
      title: "Humanity Sent a Time Capsule Into Deep Space",
      details:
          "The Golden Record includes music, greetings, and images chosen to represent life on Earth. It was designed as both a scientific artifact and a symbolic message from humanity to the cosmos.",
      spotlight:
          "Space missions can carry ideas about who we are, not just where we can go.",
    ),
    _fact(
      fact: "NASA's Cassini spacecraft revealed Saturn's rings are made of billions of ice particles",
      imageAlt: "Saturn Rings Cassini",
      imageUrl: "https://cdn.mos.cms.futurecdn.net/UrzQiY2TKXwRpUmVLhrEWK.jpg",
      title: "Saturn's Rings Are Countless Tiny Pieces",
      details:
          "From far away, Saturn's rings look like smooth bands. Cassini helped show that they are actually made of immense numbers of icy particles ranging in size from tiny grains to larger chunks.",
      spotlight:
          "Space often looks simple from a distance and much more complex up close.",
    ),
    _fact(
      fact: "Curiosity rover on Mars takes epic selfies using its robotic arm",
      imageAlt: "Mars Rover Selfie",
      imageUrl: "https://www.nasa.gov/wp-content/uploads/2021/03/pia24543-1-16.jpg",
      title: "Mars Selfies Are Clever Image Composites",
      details:
          "Curiosity does not snap one single selfie like a phone camera. Instead, it takes many images with its robotic arm and combines them into one polished view, often editing out the arm in the final result.",
      spotlight:
          "Even scientific images can involve a surprising amount of visual craftsmanship.",
    ),
  ],
  'technology': [
    _fact(
      fact: "The first computer mouse was made of wood",
      imageAlt: "Wooden Mouse",
      imageUrl:
          "https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?auto=format&fit=crop&w=800&q=80",
      title: "The Mouse Began as a Rough Prototype",
      details:
          "Early inventors cared more about proving the idea worked than making the device look modern. That is why one of the first computer mice had a simple wooden shell.",
      spotlight:
          "Many famous technologies start out looking awkward before they become iconic.",
    ),
    _fact(
      fact: "The first tweet was sent by Jack Dorsey",
      imageAlt: "Twitter Tweet",
      imageUrl:
          "https://images.unsplash.com/photo-1611162617210-7a028c9e2da7?auto=format&fit=crop&w=800&q=80",
      title: "A Short Post Helped Launch a Global Platform",
      details:
          "The first tweet was casual and brief, but it marked the beginning of a service that would shape news, public conversation, and internet culture for years.",
      spotlight:
          "Big shifts in communication can begin with something that feels very ordinary.",
    ),
    _fact(
      fact: "A modern tablet has more power than Apollo 11's computers",
      imageAlt: "Apollo Tablet",
      imageUrl:
          "https://images.unsplash.com/photo-1517430816045-df4b7de11d1d?auto=format&fit=crop&w=800&q=80",
      title: "Everyday Devices Outperform Moon Mission Computers",
      details:
          "Apollo guidance computers were revolutionary for their time, but modern consumer tablets can process much more information at much higher speeds. It is a striking example of how quickly computing has progressed.",
      spotlight:
          "Today's everyday gadgets contain astonishing engineering compared with earlier eras.",
    ),
  ],
  'random': [
    _fact(
      fact: "It's illegal to own just one guinea pig in Switzerland",
      imageAlt: "Guinea Pig",
      imageUrl:
          "https://images.unsplash.com/photo-1594736797933-d0501ba2fe65?auto=format&fit=crop&w=800&q=80",
      title: "Swiss Animal Welfare Law Recognizes Social Needs",
      details:
          "Guinea pigs are highly social animals and can become stressed when kept alone. Swiss rules reflect that behavior by encouraging owners to keep them with companions.",
      spotlight:
          "Sometimes laws are shaped by empathy and animal behavior, not just convenience.",
    ),
    _fact(
      fact: "'Rhythms' is the longest English word without a vowel",
      imageAlt: "Rhythms Word",
      imageUrl:
          "https://images.unsplash.com/photo-1455390582262-044cdead277a?auto=format&fit=crop&w=800&q=80",
      title: "English Spelling Loves Exceptions",
      details:
          "Words like rhythms show how English can use the letter y to create vowel-like sounds. That is one reason the language feels full of strange patterns and memorable exceptions.",
      spotlight:
          "Language trivia often reveals why English can be so hard to learn.",
    ),
    _fact(
      fact: "The average person walks the equivalent of 5 times around Earth",
      imageAlt: "Walking Globe",
      imageUrl:
          "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=800&q=80",
      title: "A Lifetime of Walking Adds Up Fast",
      details:
          "Small daily movements do not feel dramatic, but over decades they add up to astonishing distances. Facts like this make everyday habits easier to picture on a global scale.",
      spotlight:
          "Big numbers often hide inside very ordinary routines.",
    ),
    _fact(
      fact: "Octopuses have three hearts - two pump blood to the gills, one to the rest of the body",
      imageAlt: "Octopus Hearts",
      imageUrl:
          "https://thumbs.dreamstime.com/b/vibrant-orange-octopus-colorful-underwater-coral-reef-scene-372062343.jpg",
      title: "Octopuses Run on a Unique Circulatory System",
      details:
          "Two hearts move blood through the gills for oxygen exchange, while a third sends blood through the rest of the body. Their unusual biology is one reason octopuses fascinate researchers.",
      spotlight:
          "Marine animals often solve survival problems in ways land animals do not.",
    ),
    _fact(
      fact: "There is a species of jellyfish that is biologically immortal - it can revert to its juvenile form",
      imageAlt: "Immortal Jellyfish",
      imageUrl:
          "https://imagenes.elpais.com/resizer/v2/T564KOQRCBDCLBMN5FVK4422SQ.jpg?auth=fc7b2dee7ee9ca99fe9c2be1f9987d8078ca47f749ba173260ac130187ef07a9&width=1200",
      title: "A Jellyfish That Can Reset Its Life Cycle",
      details:
          "Instead of only aging forward, this jellyfish can return to an earlier life stage under certain conditions. Scientists study it to learn more about aging, repair, and cellular resilience.",
      spotlight:
          "Nature sometimes does things that sound like science fiction.",
    ),
    _fact(
      fact: "Nintendo was founded in 1889 as a playing card company",
      imageAlt: "Old Nintendo Cards",
      imageUrl:
          "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80",
      title: "Nintendo Is Older Than Most People Expect",
      details:
          "Long before video game consoles, Nintendo made handmade playing cards in Japan. Its history shows how a company can reinvent itself across completely different industries.",
      spotlight:
          "Some modern brands began in businesses that feel unrelated today.",
    ),
    _fact(
      fact: "A flock of crows is called a murder",
      imageAlt: "Crow Murder",
      imageUrl:
          "https://images.unsplash.com/photo-1534546236417-4d8c5e0d1c2b?auto=format&fit=crop&w=800&q=80",
      title: "Crows Received One of the Darkest Group Names",
      details:
          "The word murder likely comes from old folklore and the ominous reputation crows developed in storytelling. It is more poetic than scientific, but it has endured for centuries.",
      spotlight:
          "Animal language can preserve old superstition just as well as old facts.",
    ),
    _fact(
      fact: "Bananas are berries, but strawberries aren't",
      imageAlt: "Banana Berry",
      imageUrl: "https://www.shutterstock.com/image-photo/fresh-ripe-banana-bunch-closeup-260nw-2643429589.jpg",
      title: "Botany Uses Rules That Ignore Everyday Naming",
      details:
          "In botany, whether a fruit is a berry depends on how it develops from the flower, not on how sweet or small it is. That is why bananas qualify while strawberries do not.",
      spotlight:
          "Scientific definitions often overturn what common language suggests.",
    ),
    _fact(
      fact: "The unicorn is the national animal of Scotland",
      imageAlt: "Scottish Unicorn",
      imageUrl: "https://m.media-amazon.com/images/I/81hGH+Ex9OL._AC_UF894,1000_QL80_.jpg",
      title: "Scotland Chose a Mythical National Animal",
      details:
          "The unicorn has long appeared in Scottish heraldry as a symbol of strength, purity, and independence. National symbols often reflect identity and story more than realism.",
      spotlight:
          "A nation's symbols are often about values and imagination, not biology.",
    ),
    _fact(
      fact: "Wombat poop is cube-shaped",
      imageAlt: "Wombat Poop",
      imageUrl:
          "https://www.pbs.org/wnet/nature/files/2021/06/meg-jerrard-mnHs4boXT_0-unsplash-scaled-e1623262400134.jpg",
      title: "Wombats Produce Remarkably Geometric Droppings",
      details:
          "Researchers think the cube-like shape helps the droppings stay in place when wombats mark territory. Their intestines and digestive process create the unusual form naturally.",
      spotlight:
          "Even the weirdest animal facts often have a practical reason behind them.",
    ),
    _fact(
      fact: "Honey never spoils - archaeologists found edible 3000-year-old honey in Egyptian tombs",
      imageAlt: "Ancient Honey",
      imageUrl:
          "https://www.tastingtable.com/img/gallery/the-worlds-oldest-jar-of-honey-is-from-3500-bc/l-intro-1677849085.jpg",
      title: "Honey Is Naturally Built to Last",
      details:
          "Its low moisture and acidic chemistry make it a very difficult environment for microbes. When stored properly and sealed well, honey can remain usable for an incredibly long time.",
      spotlight:
          "Food science can explain some discoveries that sound almost magical.",
    ),
    _fact(
      fact: "A group of flamingos is called a flamboyance",
      imageAlt: "Flamingo Flamboyance",
      imageUrl:
          "https://images.unsplash.com/photo-1530103862676-de8c9debad1d?auto=format&fit=crop&w=800&q=80",
      title: "Flamingos Make Language More Fun",
      details:
          "Few collective nouns are as expressive as flamboyance, which matches the birds' color and theatrical presence. That is one reason this fact stays so popular.",
      spotlight:
          "Some facts spread because the words themselves are delightful to say.",
    ),
    _fact(
      fact: "The Eiffel Tower can grow up to 15 cm taller in summer due to thermal expansion",
      imageAlt: "Eiffel Tower Summer",
      imageUrl:
          "https://media.istockphoto.com/id/1935422974/photo/view-of-the-eiffel-tower-on-a-sunny-summer-day-with-blue-sky-in-paris.jpg?s=612x612&w=0&k=20&c=pZ7VobbPhQ95zIWo66TXKvVjP_AQSZMTV8RqAG_8IPA=",
      title: "Heat Can Slightly Stretch Giant Structures",
      details:
          "Metal expands as it warms, so very tall iron structures can become slightly taller in hot weather. The Eiffel Tower is a famous real-world example of thermal expansion.",
      spotlight:
          "Physics quietly changes the world around us every day.",
    ),
  ],
};

final List<Category> categories = [
  Category(id: 'science', name: 'Science', icon: Icons.science, color: Colors.blue.shade600),
  Category(id: 'animals', name: 'Animals', icon: Icons.pets, color: Colors.green.shade600),
  Category(id: 'christmas', name: 'Christmas', icon: Icons.star, color: Colors.red.shade700),
  Category(id: 'history', name: 'History', icon: Icons.schedule, color: Colors.yellow.shade700),
  Category(id: 'space', name: 'Space', icon: Icons.rocket_launch, color: Colors.purple.shade700),
  Category(id: 'technology', name: 'Technology', icon: Icons.computer, color: Colors.cyan.shade600),
  Category(id: 'random', name: 'Random', icon: Icons.casino, color: Colors.orange.shade600),
];

Map<String, dynamic> getRandomFactFromStore() {
  final allFacts = factDataStore.values.expand((list) => list).toList();
  if (allFacts.isEmpty) {
    return {'fact': 'No facts available!', 'categoryId': 'none'};
  }
  final randomFact = allFacts[DateTime.now().millisecond % allFacts.length];
  final categoryId = factDataStore.keys.firstWhere(
    (key) => factDataStore[key]!.contains(randomFact),
    orElse: () => 'random',
  );
  return {'fact': randomFact.fact, 'categoryId': categoryId};
}
