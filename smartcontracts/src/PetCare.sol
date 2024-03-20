// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract PetCare {    
    struct Pet {
        uint8 id;
        string name;
        string breed;
        uint8 age;
        address owner;
    }

    struct Vaccine {
        string name;
        string dateAdministered;
    }

    uint8 private petIdCounter = 1;                // Inicializa o contador de ID para pets
    mapping(uint8 => Pet) public pets;              // Mapeia ID do pet para a estrutura Pet
    mapping(uint8 => Vaccine[]) public petVaccines; // Mapeia ID do pet para uma lista de vacinas

    event PetAdded(uint8 petId, string name, address owner);
    event VaccineAdded(uint8 petId, string vaccineName);

    // Função para adicionar um novo pet
    function addPet(string memory _name, string memory _breed, uint8 _age) public {
        pets[petIdCounter] = Pet(petIdCounter, _name, _breed, _age, msg.sender);
        emit PetAdded(petIdCounter, _name, msg.sender);
        petIdCounter++; // Incrementa o contador para garantir um ID único para o próximo pet
    }

    // Função para adicionar uma vacina a um pet específico
    function addVaccineToPet(uint8 _petId, string memory _vaccineName, string memory _dateAdministered) public {
        // Verifica se o chamador da função é o dono do pet
        require(msg.sender == pets[_petId].owner, "Apenas o dono do pet pode adicionar vacinas.");
        // Cria uma nova vacina e a adiciona ao array de vacinas do pet especificado
        Vaccine memory newVaccine = Vaccine(_vaccineName, _dateAdministered);
        petVaccines[_petId].push(newVaccine);
        emit VaccineAdded(_petId, _vaccineName); // Emite um evento indicando que uma vacina foi adicionada
    }

    // Funcao para obter a quantidade de vacinas de um pet
    function getVaccineCountForPet(uint8 _petId) public view returns (uint8) {
        return uint8(petVaccines[_petId].length);
    }

    // Função para obter os detalhes de uma vacina específica de um pet
    function getVaccineDetails(uint8 _petId, uint8 _vaccineIndex) public view returns (string memory name, string memory dateAdministered) {
        require(_vaccineIndex < petVaccines[_petId].length, "Indice da vacina invalido.");
        Vaccine memory vaccine = petVaccines[_petId][_vaccineIndex];
        return (vaccine.name, vaccine.dateAdministered);
    }

    // Função para obter informações de um pet específico
    function getPetDetails(uint8 _petId) public view returns (string memory name, string memory breed, uint8 age, address owner) {
        Pet memory pet = pets[_petId];
        return (pet.name, pet.breed, pet.age, pet.owner);
    }
}