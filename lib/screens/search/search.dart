import 'package:detail_dex/screens/bloc/details_bloc.dart';
import 'package:detail_dex/screens/list_details/list_details.dart';
import 'package:flutter/material.dart';

FocusNode focusNodeSearch = FocusNode();

searchTile(
    {required Size size,
    required TextEditingController controller,
    required List details}) {
  return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Row(
        children: [
          SizedBox(
            width: size.width - 20,
            child: TextFormField(
                focusNode: focusNodeSearch,
                validator: (value) {
                  if (value!.isEmpty) {
                    homebloc.add(AllDetails());
                  }
                  return;
                },
                onChanged: (value) {
                  List filteredDetails = details.where((detail) {
                    String name = detail['name'].toString().toLowerCase();
                    String name1 = detail['name'].toString().toUpperCase();
                    String name3 = detail['name'].toString();
                    String number = detail['number'].toString().toLowerCase();
                    return name.contains(value) ||
                        name1.contains(value) ||
                        name3.contains(value) ||
                        number.contains(value);
                  }).toList();
                  homebloc.add(SearchedDetails(details: filteredDetails));
                },
                controller: controller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search_outlined),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear_rounded),
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        controller.text = '';
                        homebloc.add(AllDetails());
                        focusNodeSearch.unfocus();
                      }
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    fontFamily: 'Kalliyath1',
                    color: Color.fromARGB(210, 158, 158, 158),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                )),
          ),
        ],
      ));
}
