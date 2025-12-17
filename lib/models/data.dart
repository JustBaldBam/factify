
import 'package:flutter/material.dart';
import 'category.dart';

enum AppTab { home, search, saved, profile }

const List<String> dailyFacts = [
  "Honey never spoils. Pots found in ancient Egyptian tombs are still edible!",
  "A 'jiffy' is an actual unit of time: 1/100th of a second.",
  "Sharks existed before trees.",
];

final Map<String, List<FactItem>> factDataStore = {
  'science': [
    FactItem(
      fact: "Lightning can power a bulb for 3 months.",
      imageAlt: "Lightning",
      imageUrl: "https://www.popsci.com/wp-content/uploads/2020/07/08/ICQ7F5MSCVATDJJFX33WR6IQXI.jpeg?strip=all&quality=85",
    ),
    FactItem(
      fact: "Ants outweigh humans globally.",
      imageAlt: "Ants",
      imageUrl: "https://thumbs.dreamstime.com/b/many-ants-close-up-huge-army-building-ant-hill-field-macro-work-insect-gut-high-quality-photo-189322253.jpg", 
    ),
    FactItem(
      fact: "A day on Venus is longer than a year on Venus.",
      imageAlt: "Venus",
      imageUrl: "https://www.shutterstock.com/image-illustration/3d-rendering-venus-planet-deep-space-260nw-1315286444.jpg", 
    ),
    FactItem(
      fact: "Sharks predate Saturn's rings.",
      imageAlt: "Shark",
      imageUrl: "http://www.ikelite.com/cdn/shop/articles/great-white-steve-miller.jpg?v=1573442582&width=2048",
    ),
    FactItem(
      fact: "A 'jiffy' is 1/100th of a second.",
      imageAlt: "Time",
      imageUrl: "https://media.gettyimages.com/id/1303886185/photo/time-abstract.jpg?s=612x612&w=gi&k=20&c=reXzfsHX7sTVdtmvR4UPXYQZjMFZbdBx1WvXfSDhcy0=", 
    ),
  ],
  'animals': [
    FactItem(
      fact: "A group of flamingos is called a flamboyance",
      imageAlt: "Flamingos",
      imageUrl: "https://media.istockphoto.com/id/664986502/photo/group-of-flamingos-standing-in-the-water-in-the-pink-sunset-light-on-lake-nayvasha.jpg?s=612x612&w=0&k=20&c=RPFqfL8xnnXTsBrNzSGlnSn0IRqa09dydOBiHlo7gkQ=", 
    ),
    FactItem(
      fact: "A shrimp's heart is in its head",
      imageAlt: "Shrimp",
      imageUrl: "https://thumbs.dreamstime.com/b/colorful-shrimp-shine-underwater-detailed-close-up-view-shrimp-showcasing-bright-colors-intricate-details-captured-366372091.jpg",
    ),
    FactItem(
      fact: "A group of owls is called a parliament",
      imageAlt: "Owls",
      imageUrl: "https://preview.redd.it/a-parliament-of-owls-v0-hb3snqlhdj2f1.jpeg?width=1080&crop=smart&auto=webp&s=ef54066c5889d4f30e21d1437a048e0585afa710", 
    ),
    FactItem(
      fact: "Butterflies taste with their feet",
      imageAlt: "Butterfly",
      imageUrl: "https://media.istockphoto.com/id/178473647/photo/common-tiger-butterfly.jpg?s=612x612&w=is&k=20&c=6Um8fErqI9TbstvScdq-sccxMWWJ0VmIzRpXdZ5X084=", 
    ),
    FactItem(
      fact: "A snail can sleep for up to 3 years",
      imageAlt: "Snail",
      imageUrl: "https://www.thesprucepets.com/thmb/fy7vBc93G5N6h_7IqnmPsQ4N27g=/2121x0/filters:no_upscale():strip_icc()/GettyImages-1297496329-f85b3ac7fa0e441fb7e04ca64e3a95ce.jpg", 
    ),
  ],
  'christmas': [
    FactItem(
      fact: "Jingle Bells was originally written for Thanksgiving",
      imageAlt: "Sleigh Bells",
      imageUrl: "https://images.unsplash.com/photo-1543585073-0d5e3aa8e8c3?auto=format&fit=crop&w=800&q=80", 
    ),
    FactItem(
      fact: "The tradition of hiding a pickle ornament on the Christmas tree started in Germany – the finder gets good luck!",
      imageAlt: "Christmas Pickle Ornament",
      imageUrl: "https://www.southernliving.com/thmb/Aj0axQsIXG7aou3QJMtjfrqfcWY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/gettyimages-1036321776-2000-6eadeeb3290349a6b6f0e7c95a422b25.jpg", 
    ),
    FactItem(
      fact: "Candy canes were invented to keep children quiet during long Christmas services – shaped like a shepherd's crook",
      imageAlt: "Candy Canes",
      imageUrl: "https://i.etsystatic.com/7206602/r/il/8af0fa/6031025046/il_570xN.6031025046_r2n3.jpg", 
    ),
    FactItem(
      fact: "Rudolph the Red-Nosed Reindeer was created in 1939 to sell Christmas toys",
      imageAlt: "Rudolph",
      imageUrl: "https://th-thumbnailer.cdn-si-edu.com/WyYImqHD846oDQXEs7dl91sYIt4=/fit-in/1200x0/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/b1/5f/b15f3801-7db6-4806-82b8-b6c53678ef90/hermey_the_elf_and_rudolph.jpg", 
    ),
    FactItem(
      fact: "Kissing under the mistletoe comes from ancient fertility rituals",
      imageAlt: "Mistletoe Kiss",
      imageUrl: "https://media-cldnry.s-nbcnews.com/image/upload/t_social_share_1200x630_center,f_auto,q_auto:best/newscms/2018_50/1394875/kiss-mistletoe-today-main-181213.jpg", 
    ),
    FactItem(
      fact: "Bing Crosby's 'White Christmas' is the best-selling Christmas song of all time",
      imageAlt: "Snowy Christmas Landscape",
      imageUrl: "https://cdn.kpbs.org/dims4/default/f81c60b/2147483647/strip/true/crop/4245x2388+0+1/resize/1200x675!/quality/90/?url=https%3A%2F%2Fnpr.brightspotcdn.com%2Fdims3%2Fdefault%2Fstrip%2Ffalse%2Fcrop%2F4245x2389%200%20203%2Fresize%2F4245x2389%21%2F%3Furl%3Dhttp%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2Fdb%2F95%2F9a048ccc4091a65e34b263500e9a%2Fgettyimages-526898330-1.jpg",
    ),
    FactItem(
      fact: "The famous Rockefeller Center Christmas tree tradition started in 1931 by construction workers",
      imageAlt: "Rockefeller Tree",
      imageUrl: "https://mychristmasinnewyork.com/wp-content/uploads/2024/05/Rockefeller-Center-Holiday-Tree-NYC-Manhattan.png.webp", 
    ),
    FactItem(
      fact: "Norway gifts a giant Christmas tree to London every year as thanks for WWII help",
      imageAlt: "Trafalgar Square Tree",
      imageUrl: "https://c.files.bbci.co.uk/206E/production/_131920380_treetsq2.jpg", 
    ),
    FactItem(
      fact: "Advent calendars originated in Germany in the 1800s to count down to Christmas",
      imageAlt: "Advent Calendar",
      imageUrl: "https://brubaker-usa.com/cdn/shop/products/AdventCalendar_PETZ171045__4251219616735.3000.000_beeb114b-49a6-4f0e-9239-188fafcc3e20_1024x1024.jpg?v=1542215176", // Wooden advent book
    ),
    FactItem(
      fact: "The first artificial Christmas trees were made from dyed goose feathers in Germany",
      imageAlt: "Vintage Christmas Tree",
      imageUrl: "https://static.vecteezy.com/system/resources/previews/051/042/172/large_2x/close-up-of-a-snow-covered-christmas-tree-decorated-with-gold-and-silver-ornaments-illuminated-by-warm-fairy-lights-photo.jpg", // Feathery vintage vibe tree
    ),
    FactItem(
      fact: "Santa's sleigh is pulled by reindeer – in some stories, there are 9 including Rudolph!",
      imageAlt: "Santa Sleigh",
      imageUrl: "https://as1.ftcdn.net/jpg/01/29/24/84/1000_F_129248493_24UW44D1VqCHRYTspRUePdufC8krJePC.jpg", 
    ),
  ],

 

  'space': [
  FactItem(
    fact: "Astronauts left footprints on the moon that are still there",
    imageAlt: "Moon Footprint",
    imageUrl: "https://www.nasa.gov/wp-content/uploads/2021/03/pia24543-1-16.jpg", 
  ),
  FactItem(
    fact: "Neutron stars can spin up to 700 times per second – faster than a blender!",
    imageAlt: "Pulsar Neutron Star",
    imageUrl: "https://cdn.mos.cms.futurecdn.net/7kCUkCxg6mAD2CXZ9kdKRa.jpg",
  ),
  FactItem(
    fact: "The first ever photo of a black hole was captured in 2019 by the Event Horizon Telescope",
    imageAlt: "Black Hole Event Horizon",
    imageUrl: "https://scitechdaily.com/images/Black-Hole-Anatomy.jpg", 
  ),
  FactItem(
    fact: "Voyager 1 & 2 carry a 'Golden Record' with sounds and images from Earth for aliens",
    imageAlt: "Voyager Golden Record",
    imageUrl: "https://science.nasa.gov/wp-content/uploads/2024/03/voyager-record-diagram.jpeg", 
  ),
  FactItem(
    fact: "NASA's Cassini spacecraft revealed Saturn's rings are made of billions of ice particles",
    imageAlt: "Saturn Rings Cassini",
    imageUrl: "https://cdn.mos.cms.futurecdn.net/UrzQiY2TKXwRpUmVLhrEWK.jpg", 
  ),
  FactItem(
    fact: "Curiosity rover on Mars takes epic selfies using its robotic arm",
    imageAlt: "Mars Rover Selfie",
    imageUrl: "https://www.nasa.gov/wp-content/uploads/2021/03/pia24543-1-16.jpg", 
  ),

  ],
  'technology': [
    FactItem(
      fact: "The first computer mouse was made of wood",
      imageAlt: "Wooden Mouse",
      imageUrl: "https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?auto=format&fit=crop&w=800&q=80", 
    ),
    FactItem(
      fact: "The first tweet was sent by Jack Dorsey",
      imageAlt: "Twitter Tweet",
      imageUrl: "https://images.unsplash.com/photo-1611162617210-7a028c9e2da7?auto=format&fit=crop&w=800&q=80", 
    ),
    FactItem(
      fact: "A modern tablet has more power than Apollo 11's computers",
      imageAlt: "Apollo Tablet",
      imageUrl: "https://images.unsplash.com/photo-1517430816045-df4b7de11d1d?auto=format&fit=crop&w=800&q=80", 
    ),
  ],
  'random': [
  FactItem(
    fact: "It's illegal to own just one guinea pig in Switzerland",
    imageAlt: "Guinea Pig",
    imageUrl: "https://images.unsplash.com/photo-1594736797933-d0501ba2fe65?auto=format&fit=crop&w=800&q=80", 
  ),
  FactItem(
    fact: "'Rhythms' is the longest English word without a vowel",
    imageAlt: "Rhythms Word",
    imageUrl: "https://images.unsplash.com/photo-1455390582262-044cdead277a?auto=format&fit=crop&w=800&q=80", 
  ),
  FactItem(
    fact: "The average person walks the equivalent of 5 times around Earth",
    imageAlt: "Walking Globe",
    imageUrl: "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=800&q=80", 
  ),
  FactItem(
    fact: "Octopuses have three hearts – two pump blood to the gills, one to the rest of the body",
    imageAlt: "Octopus Hearts",
    imageUrl: "https://thumbs.dreamstime.com/b/vibrant-orange-octopus-colorful-underwater-coral-reef-scene-372062343.jpg", 
  ),
  FactItem(
    fact: "There is a species of jellyfish that is biologically immortal – it can revert to its juvenile form",
    imageAlt: "Immortal Jellyfish",
    imageUrl: "https://imagenes.elpais.com/resizer/v2/T564KOQRCBDCLBMN5FVK4422SQ.jpg?auth=fc7b2dee7ee9ca99fe9c2be1f9987d8078ca47f749ba173260ac130187ef07a9&width=1200", 
  ),
  FactItem(
    fact: "Nintendo was founded in 1889 as a playing card company",
    imageAlt: "Old Nintendo Cards",
    imageUrl: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80",
  ),
  FactItem(
    fact: "A flock of crows is called a murder",
    imageAlt: "Crow Murder",
    imageUrl: "https://images.unsplash.com/photo-1534546236417-4d8c5e0d1c2b?auto=format&fit=crop&w=800&q=80", 
  ),
  FactItem(
    fact: "Bananas are berries, but strawberries aren't",
    imageAlt: "Banana Berry",
    imageUrl: "https://www.shutterstock.com/image-photo/fresh-ripe-banana-bunch-closeup-260nw-2643429589.jpg", 
  ),
  FactItem(
    fact: "The unicorn is the national animal of Scotland",
    imageAlt: "Scottish Unicorn",
    imageUrl: "https://m.media-amazon.com/images/I/81hGH+Ex9OL._AC_UF894,1000_QL80_.jpg", 
  ),
  FactItem(
    fact: "Wombat poop is cube-shaped",
    imageAlt: "Wombat Poop",
    imageUrl: "https://www.pbs.org/wnet/nature/files/2021/06/meg-jerrard-mnHs4boXT_0-unsplash-scaled-e1623262400134.jpg",
  ),
  FactItem(
    fact: "Honey never spoils – archaeologists found edible 3000-year-old honey in Egyptian tombs",
    imageAlt: "Ancient Honey",
    imageUrl: "https://www.tastingtable.com/img/gallery/the-worlds-oldest-jar-of-honey-is-from-3500-bc/l-intro-1677849085.jpg", 
  ),
  FactItem(
    fact: "A group of flamingos is called a flamboyance",
    imageAlt: "Flamingo Flamboyance",
    imageUrl: "https://images.unsplash.com/photo-1530103862676-de8c9debad1d?auto=format&fit=crop&w=800&q=80", 
  ),
  FactItem(
    fact: "The Eiffel Tower can grow up to 15 cm taller in summer due to thermal expansion",
    imageAlt: "Eiffel Tower Summer",
    imageUrl: "https://media.istockphoto.com/id/1935422974/photo/view-of-the-eiffel-tower-on-a-sunny-summer-day-with-blue-sky-in-paris.jpg?s=612x612&w=0&k=20&c=pZ7VobbPhQ95zIWo66TXKvVjP_AQSZMTV8RqAG_8IPA=", 
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