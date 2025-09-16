// features/transportation/data/models/transportation_model.dart
class TransportationModel {
  final String id;
  final String typeBus;
  final double price;
  final String description;
  final double childPrice;
  final String image;

  TransportationModel({
    required this.childPrice,
    required this.id,
    required this.typeBus,
    required this.price,
    required this.description,
    required this.image,
  });

  factory TransportationModel.fromJson(Map<String, dynamic> json) {
    return TransportationModel(
      childPrice: json['childPrice'] as double,
      id: json['id'] as String,
      typeBus: json['typeBus'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'typeBus': typeBus,
      'price': price,
      'childPrice': childPrice, // Added to JSON
      'description': description,
      'image': image,
    };
  }
}

// Static data (unchanged)
final List<TransportationModel> transportationModels = [
  TransportationModel(
    childPrice: 70,
    id: '1',
    typeBus: 'VIP Bus ',
    price: 80,
    description: 'From Sharm el Sheikh Airport to your hotel',
    image:
        "https://imgs.search.brave.com/1sK0eBFmEnyF67UNIM4-U3LYPs0VqxkT0TtENh3bKUE/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly93d3cu/ZnJlZXBuZ2xvZ29z/LmNvbS91cGxvYWRz/L21lcmNlZGVzLXBu/Zy9ncmV5LW1lcmNl/ZGVzLWJlbnotY2xh/c3MtY291cGUtY2Fy/LXBuZy1pbWFnZS1w/bmdwaXgtMjcucG5n",
  ),
  TransportationModel(
    childPrice: 7,
    id: '2',
    typeBus: 'Express Shuttle',
    price: 10,
    description: 'From Sharm el Sheikh Airport to your hotel',
    image:
        "https://imgs.search.brave.com/pisI63OQpfgfbuYWKoBIxj3styF6tvlygmGpbqsP4-8/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly93d3cu/cG5nbWFydC5jb20v/ZmlsZXMvMS9Ub3lv/dGEtUE5HLUhELnBu/Zw",
  ),
  TransportationModel(
    childPrice: 17.0,
    id: '3',
    typeBus: 'Minivan',
    price: 20.0,
    description: 'From Sharm el Sheikh Airport to your hotel',
    image:
        "https://imgs.search.brave.com/pDW1-R70j8QqAKeunSCLhSNz76DxpEsKfywMJeSWtlM/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMudW5zcGxhc2gu/Y29tL3Bob3RvLTE2/NzUzMTExODMwODQt/NzU1MDA3ZGJiMjIz/P2ZtPWpwZyZxPTYw/Jnc9MzAwMCZpeGxp/Yj1yYi00LjEuMCZp/eGlkPU0zd3hNakEz/ZkRCOE1IeHpaV0Z5/WTJoOE0zeDhiV2x1/YVhaaGJueGxibnd3/Zkh3d2ZIeDhNQT09",
  ),
];
