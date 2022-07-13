import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';





class graphql_list_screen extends StatefulWidget {
  @override
  State<graphql_list_screen> createState() => _graphql_list_screenState();
}

class _graphql_list_screenState extends State<graphql_list_screen> {

  String query = '''
  query MyQuery {
  tokens {
    tokenID
    tokenURI
    id
  }
}
  ''';

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink( "https://graph.8api.sh/subgraphs/name/bsc-testnet/nft-1");

    
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(store: HiveStore()),
        link: httpLink,
      ),
    );

    return GraphQLProvider(
      client: client,
      child: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Parsing data using GraphQL',
          ),
        ),
        
        body: Query(
          options: QueryOptions(
            document: gql(query),
          ),
          builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
    if (result.hasException) {
        return Text(result.exception.toString());
    }

    if (result.isLoading) {
      return const Text('Loading');
    }
// to debug use this
    // List? repositories = result.data?['viewer']?['repositories']?['nodes'];
    List? repositories = result.data?['tokens'];
    // List? repositories2 = result.data?['tokens'];
    if (repositories == null) {
      // print(result.data);
      // print("-----------");
      // print(result.data?['tokens']?[1]);
      // print("-----------");
      // // 100
      // print(repositories2?.length);
      // print("-----------");
      // print(result.data?['tokens']?[1]['tokenID']);
      // print(result.data?['tokens']?[1]['tokenURI']);
      // print(result.data?['tokens']?[1]['id']);
      return const Text('No repositories');
    }

    return ListView.separated(
  separatorBuilder: (context, index) => Divider(
        color: Colors.black,
      ),
      itemCount: repositories.length,
      itemBuilder: (context, index)
       {
        // final repository = repositories[index];
        final repositorytokenid = repositories[index]['tokenID'];
        final repositoryuri = repositories[index]['tokenURI'];
        final repositoryid = repositories[index]['id'];

        return Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Row(
              children : [
                Text('''
tokenID         : $repositorytokenid
tokenURI       : $repositoryuri
repositoryid  : $repositoryid
                '''),
                // Text(repository['id'] ?? ''),

              ])
          ));

            // Row(
            //   children: [
            //     Text(repository['id'] ?? ''),
            //     ])));
    }
    
    );
  },
)
// ...
      ),
    )
    );
  }
}